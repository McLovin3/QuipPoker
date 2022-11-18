extends CanvasLayer
class_name PokerGame

onready var _name_list: NameList = $NameList
onready var _card_manager: CardManager = $CardManager
onready var _popup_text: PopupText = $PopupText
onready var _http_request: HTTPRequest = $HTTPRequest
onready var _check_button: Button = $CheckButton
onready var _fold_button: Button = $FoldButton

# TODO Change order clockwise after every poker game
# TODO Game closing returns to main menu
# TODO No duplicate names
# TODO Min 3 players
# TODO turn timer

enum Plays { CHECK, FOLD, RAISE, CALL, ALL_IN }

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
	rpc("_set_player_names", GameManager.get_player_names())
	_initialise_player_cards()
	rpc_id(_players[0], "_set_turn")


func _initialise_player_cards() -> void:
	for id in _players:
		var player_cards = [GameManager.get_next_card(), GameManager.get_next_card()]
		GameManager.player_info[id]["cards"] = [
			GameManager.get_api_value(player_cards[0]), GameManager.get_api_value(player_cards[1])
		]
		rpc_id(id, "_set_player_cards", player_cards)


func _is_turn_over() -> bool:
	return (_current_player + 1) == _players.size()


func _get_current_player_name() -> String:
	return GameManager.player_info.get(_players[_current_player])["name"]


mastersync func _send_action(action: int):
	var id = get_tree().get_rpc_sender_id()

	match action:
		Plays.CHECK:
			GameManager.player_info.get(id)["action"] = Plays.CHECK
			rpc("_set_player_action", _get_current_player_name(), "check")
			if _is_turn_over():
				_turn_over()
			else:
				_current_player += 1
				rpc("_set_currently_playing", _get_current_player_name())
				rpc_id(_players[_current_player], "_set_turn")

		Plays.FOLD:
			GameManager.player_info.get(id)["action"] = Plays.FOLD
			rpc("_set_player_action", _get_current_player_name(), "fold")
			_players.erase(id)
			if _players.size() == 1:
				rpc("_disable_buttons")
				rpc(
					"_display_text",
					(
						"Everyone else folded, "
						+ GameManager.player_info.get(_players[0])["name"]
						+ " wins "
						+ str(_pot)
						+ " chips!"
					)
				)

			elif _is_turn_over():
				_turn_over()

			else:
				rpc_id(_players[_current_player], "_set_turn")
				rpc("_set_currently_playing", _get_current_player_name())


func _turn_over():
	_turn += 1
	var new_card = GameManager.get_next_card()
	_table_cards.append(new_card)
	rpc("_flip_next_card", new_card)

	if _turn == 4:
		rpc("_disable_buttons")
		_determine_winner()

	else:
		_current_player = 0
		rpc("_set_player_names", GameManager.get_player_names())
		rpc("_set_currently_playing", _get_current_player_name())
		rpc_id(_players[_current_player], "_set_turn")


# Player Functions
puppetsync func _set_player_action(name: String, action: String) -> void:
	_name_list.set_player_action_by_name(name, action)

puppetsync func _set_currently_playing(name: String) -> void:
	_name_list.set_current_player_by_name(name)

puppetsync func _set_player_names(names: Array) -> void:
	_name_list.set_player_names(names)

puppetsync func _set_turn() -> void:
	_popup_text.display_text("Your turn")
	_check_button.disabled = false
	_fold_button.disabled = false

puppetsync func _display_text(text: String) -> void:
	_popup_text.display_text(text)

puppetsync func _disable_buttons() -> void:
	_check_button.disabled = true
	_fold_button.disabled = true

puppetsync func _flip_next_card(card_value: Dictionary) -> void:
	_card_manager.flip_next_card(card_value)

puppetsync func _set_table_cards(table_values: Array) -> void:
	_card_manager.set_initial_table_cards(table_values)

puppetsync func _set_player_cards(player_values: Array) -> void:
	_card_manager.set_initial_player_cards(player_values)


func _on_FoldButton_pressed():
	_disable_buttons()
	rpc("_send_action", Plays.FOLD)


func _on_CheckButton_pressed():
	_disable_buttons()
	rpc("_send_action", Plays.CHECK)


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

	# if winners.size() == 1:
	# 	_winner_label.text = "Player " + str(winners[0]) + " wins!"
	# else:
	# 	_winner_label.text = "Players " + str(winners) + " tie!"

	# for player_id in _players_information.keys():
	# 	if (
	# 		winner["cards"].split(",")[0] == _players_information[player_id]["cards"][0]
	# 		and winner["cards"].split(",")[1] == _players_information[player_id]["cards"][1]
	# 	):
