extends CanvasLayer
class_name PokerGame

var ROUND_FEE_AMOUNT = 100

onready var _raise_button: Button = $RaiseButton
onready var _raise_input: ShakingInput = $RaiseInput
onready var _pot_label: Label = $PotLabel
onready var _call_button: Button = $CallButton
onready var _all_in_button: Button = $AllInButton
onready var _bet_button: Button = $BetButton
onready var _bet_input: ShakingInput = $BetInput
onready var _chip_label: Label = $ChipLabel
onready var _name_list: NameList = $NameList
onready var _card_manager: CardManager = $CardManager
onready var _popup_text: PopupText = $PopupText
onready var _http_request: HTTPRequest = $HTTPRequest
onready var _check_button: Button = $CheckButton
onready var _fold_button: Button = $FoldButton

# TODO Change order clockwise after every poker game
# TODO Game closing returns to main menu
# TODO No duplicate names
# TODO Max 8 players
# TODO Min 3 players
# TODO turn timer

enum Plays { CHECK, FOLD, RAISE, BET, CALL, ALL_IN }

var _last_puppet_bet_amount: int = 0
var _last_bet_amount: int = 0
var _last_betting_player: int = 0
var _player_chip_count: int
var _players = []
var _table_cards: Array = []
var _current_player: int = 0
var _turn: int = 1
var _pot = 0


func _ready():
	if get_tree().is_network_server():
		_start_game()


# Host Functions


func _start_game():
	GameManager.reinitialise_game_manager()
	_players = GameManager.player_id_list
	_table_cards.append_array(
		[
			GameManager.get_next_card(),
			GameManager.get_next_card(),
		]
	)
	rpc("_set_table_cards", _table_cards)
	rpc("_set_player_names", _get_player_names())
	_initialise_players()
	rpc_id(1, "_set_turn", 0, 0)


func _initialise_players() -> void:
	for id in _players:
		var player_cards = [GameManager.get_next_card(), GameManager.get_next_card()]
		if GameManager.player_info.get(id)["chips"] >= ROUND_FEE_AMOUNT:
			GameManager.player_info.get(id)["chips"] -= ROUND_FEE_AMOUNT
			_pot += ROUND_FEE_AMOUNT
			rpc("_set_pot_amount", _pot)
		else:
			_pot += GameManager.player_info.get(id)["chips"]
			GameManager.player_info.get(id)["chips"] = 0
			GameManager.player_info.get(id)["action"] = Plays.ALL_IN
			rpc("_set_pot_amount", _pot)

		rpc("_set_chip_count", GameManager.player_info.get(id)["chips"])
		GameManager.player_info[id]["cards"] = [
			GameManager.get_api_value(player_cards[0]), GameManager.get_api_value(player_cards[1])
		]
		rpc_id(id, "_set_player_cards", player_cards)


func _is_turn_over() -> bool:
	var action_counts : Array = []
	for id in GameManager.player_id_list:
		if not (_get_player_info(id).get("action") in [Plays.FOLD, Plays.ALL_IN]):
			action_counts.append(_get_player_info(id)["action_count"])
	
	action_counts.sort()
	return action_counts[0] == action_counts[action_counts.size() - 1] == 1 or action_counts[0] == action_counts[action_counts.size() - 1] == 2


func _get_player_names() -> Array:
	var names: Array = []

	for id in GameManager.player_id_list:
		if GameManager.player_info.get(id).get("action") == Plays.FOLD:
			names.append(GameManager.player_info.get(id).get("name") + " (folded)")
		elif GameManager.player_info.get(id).get("action") == Plays.ALL_IN:
			names.append(GameManager.player_info.get(id).get("name") + " (all in)")
		elif GameManager.player_info.get(id).get("chips") <= 0:
			names.append(GameManager.player_info.get(id).get("name") + " (busted)")
		else:
			names.append(GameManager.player_info.get(id).get("name"))

	return names


func _get_player_info(id: int) -> Dictionary:
	return GameManager.player_info.get(id)


func _get_current_player_name() -> String:
	return GameManager.player_info.get(_players[_current_player])["name"]


func _is_one_player_left() -> bool:
	var count: int = 0

	for id in GameManager.player_id_list:
		if not (
			_get_player_info(id).get("action") in [Plays.FOLD, Plays.ALL_IN]
			or _get_player_info(id).get("chips") <= 0
		):
			count += 1

	return count == 1

func _get_first_player_id() -> int:
	for id in GameManager.player_id_list:
		if not (
			_get_player_info(id).get("action") in [Plays.FOLD, Plays.ALL_IN]
			or _get_player_info(id).get("chips") <= 0
		):
			_current_player = GameManager.player_id_list.find(id)
			return id
	return -1

func _get_next_player_id() -> int:
	for id in GameManager.player_id_list.slice(
		_current_player + 1, GameManager.player_id_list.size()
	):
		if (
			_get_player_info(id).get("action") in [Plays.FOLD, Plays.ALL_IN]
			or _get_player_info(id).get("chips") <= 0
		):
			pass
		else:
			_current_player = GameManager.player_id_list.find(id)
			return _players[_current_player]

	for id in GameManager.player_id_list.slice(0, _current_player):
		if (
			_get_player_info(id).get("action") in [Plays.FOLD, Plays.ALL_IN]
			or _get_player_info(id).get("chips") <= 0
		):
			pass
		else:
			_current_player = GameManager.player_id_list.find(id)
			return _players[_current_player]

	return -1


mastersync func _send_action(action: int, bet_amount: int):
	var id = get_tree().get_rpc_sender_id()
	GameManager.player_info.get(id)["action_count"] += 1

	match action:
		Plays.ALL_IN:
			GameManager.player_info[id]["action"] = Plays.ALL_IN
			GameManager.player_info[id]["chips"] = 0
			rpc("_set_player_action", _get_current_player_name(), "All In")
			_pot += bet_amount
			rpc("_set_pot_amount", _pot)

		Plays.RAISE:
			GameManager.player_info[id]["action"] = Plays.RAISE
			GameManager.player_info[id]["chips"] -= bet_amount
			rpc("_set_player_action", _get_current_player_name(), "bet " + str(bet_amount))
			_pot += bet_amount
			rpc("_set_pot_amount", _pot)
			_last_betting_player = id
			_last_bet_amount = bet_amount

		Plays.CALL:
			GameManager.player_info[id]["action"] = Plays.CALL
			GameManager.player_info[id]["chips"] -= bet_amount
			rpc("_set_player_action", _get_current_player_name(), "call")
			_pot += bet_amount
			rpc("_set_pot_amount", _pot)

		Plays.BET:
			GameManager.player_info[id]["action"] = Plays.BET
			GameManager.player_info[id]["chips"] -= bet_amount
			rpc("_set_player_action", _get_current_player_name(), "bet " + str(bet_amount))
			_pot += bet_amount
			rpc("_set_pot_amount", _pot)
			_last_betting_player = id
			_last_bet_amount = bet_amount

		Plays.CHECK:
			GameManager.player_info.get(id)["action"] = Plays.CHECK
			rpc("_set_player_action", _get_current_player_name(), "check")
			_last_bet_amount = 0

		Plays.FOLD:
			GameManager.player_info.get(id)["action"] = Plays.FOLD
			rpc("_set_player_action", _get_current_player_name(), "fold")

	var next_player_id = _get_next_player_id()

	if _is_one_player_left(): 
		rpc("_disable_buttons")
		rpc(
			"_display_text",
			(
				"Everyone else folded, "
				+ _get_player_info(next_player_id).get("name")
				+ " wins "
				+ str(_pot)
				+ " chips!"
			)
		)
	
	elif (_get_player_info(next_player_id).get("action_count") == 2
		or _everyone_folded_or_checked()
		or _last_betting_player == next_player_id):
		_turn_over()

	else:
		rpc("_set_currently_playing", _get_current_player_name())
		rpc_id(next_player_id, "_set_turn", _last_bet_amount, 
			GameManager.player_info.get(next_player_id).get("action_count"))

func _turn_over() -> void: 
	_turn += 1
	_last_bet_amount = 0
	_last_betting_player = 0
	_last_puppet_bet_amount = 0
	var new_card = GameManager.get_next_card()
	_table_cards.append(new_card)
	rpc("_flip_next_card", new_card)

	if _turn == 4:
		rpc("_disable_buttons")
		_determine_winner()

	else:
		for player_id in GameManager.player_id_list:
			GameManager.player_info.get(player_id)["action_count"] = 0

			if (GameManager.player_info.get(player_id)["action"] != Plays.FOLD
				and GameManager.player_info.get(player_id)["action"] != Plays.ALL_IN):
				GameManager.player_info.get(player_id)["action"] = -1

		rpc("_set_player_names", _get_player_names())
		rpc("_set_currently_playing", _get_current_player_name())
		rpc_id(_get_first_player_id(), "_set_turn", 0, 0)

func _everyone_folded_or_checked():
	for id in GameManager.player_id_list:
		if not (
			_get_player_info(id).get("action") in [Plays.FOLD, Plays.CHECK]
			or _get_player_info(id).get("chips") <= 0
		):
			return false

	return true

# Player Functions
puppetsync func _set_chip_count(amount: int) -> void:
	_player_chip_count = amount
	_chip_label.text = "Current chips: " + str(amount)

puppetsync func _set_player_action(name: String, action: String) -> void:
	_name_list.set_player_action_by_name(name, action)

puppetsync func _set_currently_playing(name: String) -> void:
	_name_list.set_current_player_by_name(name)

puppetsync func _set_player_names(names: Array) -> void:
	_name_list.set_player_names(names)

var _current_bet: int = 0
puppetsync func _set_turn(bet_amount: int, nb_action: int) -> void:
	_current_bet = bet_amount
	_popup_text.display_text("Your turn")
	if _current_bet == 0:
		_check_button.disabled = false
		_bet_button.disabled = false
		_bet_input.editable = true
			
	elif _current_bet > _player_chip_count:
		_all_in_button.disabled = false
		
	elif _current_bet > 0 and nb_action == 1:
		_call_button.disabled = false

	elif _current_bet > 0:
		_call_button.disabled = false
		_raise_button.disabled = false
		_raise_input.editable = true

	_fold_button.disabled = false

puppetsync func _set_pot_amount(new_pot: int) -> void:
	_pot_label.text = "Pot: " + str(new_pot)

puppetsync func _display_text(text: String) -> void:
	_popup_text.display_text(text)

puppetsync func _disable_buttons() -> void:
	_all_in_button.disabled = true
	_bet_button.disabled = true
	_bet_input.editable = false
	_call_button.disabled = true
	_check_button.disabled = true
	_fold_button.disabled = true
	_raise_button.disabled = true
	_raise_input.editable = false

puppetsync func _flip_next_card(card_value: Dictionary) -> void:
	_card_manager.flip_next_card(card_value)

puppetsync func _set_table_cards(table_values: Array) -> void:
	_card_manager.set_initial_table_cards(table_values)

puppetsync func _set_player_cards(player_values: Array) -> void:
	_card_manager.set_initial_player_cards(player_values)


func _on_FoldButton_pressed():
	_disable_buttons()
	_popup_text.display_text("Folded")
	rpc("_send_action", Plays.FOLD, 0)


func _on_CheckButton_pressed():
	_disable_buttons()
	_popup_text.display_text("Checked")
	rpc("_send_action", Plays.CHECK, 0)


func _on_RaiseButton_pressed():
	var bet_amount = _raise_input.text

	if (
		!_raise_input.text.is_valid_integer()
		or int(_raise_input.text) + _current_bet > _player_chip_count
		or int(_raise_input.text) + _current_bet <= _current_bet
	):
		_bet_input.shake()

	else:
		bet_amount = int(bet_amount) + _current_bet

		_disable_buttons()
		rpc("_send_action", Plays.RAISE, bet_amount)
		_popup_text.display_text("Raised to " + str(bet_amount) + " chips")
		_set_chip_count(_player_chip_count - bet_amount)
		_last_puppet_bet_amount = bet_amount
		_player_chip_count = _player_chip_count - bet_amount


func _on_BetButton_pressed():
	var bet_amount = _bet_input.text

	if (
		!_bet_input.text.is_valid_integer()
		or int(_bet_input.text) > _player_chip_count
		or int(_bet_input.text) <= 0
	):
		_bet_input.shake()

	else:
		_disable_buttons()
		_last_puppet_bet_amount = int(bet_amount)
		rpc("_send_action", Plays.BET, int(bet_amount))
		_popup_text.display_text("Bet " + str(int(bet_amount)) + " chips")
		_player_chip_count -= int(bet_amount)
		_set_chip_count(_player_chip_count)


func _on_AllInButton_pressed():
	_disable_buttons()
	_popup_text.display_text("All in")
	rpc("_send_action", Plays.ALL_IN, _player_chip_count)
	_set_chip_count(0)
	_player_chip_count = 0


func _on_CallButton_pressed():
	_disable_buttons()
	_current_bet -= _last_puppet_bet_amount
	_last_puppet_bet_amount = 0
	_popup_text.display_text("Called")
	rpc("_send_action", Plays.CALL, _current_bet)
	_player_chip_count -= _current_bet
	_set_chip_count(_player_chip_count)


# Universal Functions


func _get_player_api_hands() -> String:
	var player_hands: String = ""

	for player in _players:
		if GameManager.player_info.get(player).get("action") != Plays.FOLD:
			player_hands += "&pc[]="
			for card in GameManager.player_info[player]["cards"]:
				player_hands += card + ","

	return player_hands


func _determine_winner():
	_http_request.request(
		(
			"https://api.pokerapi.dev/v1/winner/texas_holdem?"
			+ _card_manager.get_table_hand_api_values()
			+ _get_player_api_hands()
		)
	)


func _on_HTTPRequest_request_completed(
	_result: int, _response_code: int, _headers: PoolStringArray, body: PoolByteArray
) -> void:
	var result: Dictionary = JSON.parse(body.get_string_from_utf8()).result
	print(result)

	# var winners: Array = result["winners"]
	# if winners.size() == 1:
	# 	for id in _players:
	# 		if (
	# 			winners.split(",")[0] == GameManager.player_info[id]["hand"][player_id]["cards"][0]
	# 			and winners.split(",")[1] == _players_information[player_id]["cards"][1]
	# 		):
	# 			rpc("_display_text")
