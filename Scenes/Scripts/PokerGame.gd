extends CanvasLayer
class_name PokerGame

var _card: PackedScene = preload("res://Card/Card.tscn")
onready var _name_list: ItemList = $NameList
onready var _new_game_timer: Timer = $NewGameTimer
onready var _turn_timer: Timer = $TurnTimer
#Card position
onready var _first_table_position: Position2D = $TableCard1
onready var _second_table_position: Position2D = $TableCard2
onready var _third_table_position: Position2D = $TableCard3
onready var _fourth_table_position: Position2D = $TableCard4
onready var _fifth_table_position: Position2D = $TableCard5

onready var _first_player_position: Position2D = $PlayerCard1
onready var _second_player_position: Position2D = $PlayerCard2

onready var _http_request: HTTPRequest = $HTTPRequest
onready var _check_button: Button = $CheckButton
onready var _fold_button: Button = $FoldButton

enum Plays { CHECK, FOLD }

var _players: Dictionary = {}
var _table_cards: Array = []
var _turn: int
var _current_player: int
var _table_cards_api_values: String = ""


func _ready():
	if get_tree().is_network_server():
		_start_game()


# Server Functions


func _start_game():
	_table_cards.clear()
	_turn = 1
	_current_player = 0

	_init_table_cards()
	for id in NetworkManager.players.keys():
		_players[id] = id
		var player_cards = [GameManager.get_next_card(), GameManager.get_next_card()]
		_players[id] = {
			"cards":
			[GameManager.get_api_value(player_cards[0]), GameManager.get_api_value(player_cards[1])]
		}
		rpc_id(id, "_set_player_cards", player_cards)

	rpc_id(_players.keys()[0], "_set_turn")


func _init_table_cards():
	_table_cards.append_array(
		[
			GameManager.get_next_card(),
			GameManager.get_next_card(),
		]
	)
	rpc("_set_table_cards", _table_cards)


mastersync func _send_action(action: int):
	var id = get_tree().get_rpc_sender_id()
	print("Player " + str(id) + " sent action " + str(action))

	match action:
		Plays.CHECK:
			_players[id]["action"] = "CHECK"
		Plays.FOLD:
			_players[id]["action"] = "FOLD"

	if (_current_player + 1) == _players.keys().size():
		_turn += 1
		_table_cards.append(GameManager.get_next_card())
		rpc("_set_table_cards", _table_cards)

		if _turn == 4:
			rpc("_disable_buttons")
			_determine_winner()

		else:
			_current_player = 0
			rpc_id(_players.keys()[_current_player], "_set_turn")

	else:
		_current_player += 1
		rpc_id(_players.keys()[_current_player], "_set_turn")


# Client Functions

puppetsync func _disable_buttons():
	_check_button.disabled = true
	_fold_button.disabled = true

puppetsync func _set_table_cards(table_cards: Array):
	_table_cards_api_values = ""
	_create_card(Vector2(1.5, 1.5), _first_table_position.position, 0, table_cards[0])
	_create_card(Vector2(1.5, 1.5), _second_table_position.position, 0, table_cards[1])

	if table_cards.size() >= 3:
		_create_card(Vector2(1.5, 1.5), _third_table_position.position, 0, table_cards[2])
	else:
		_create_face_down_card(Vector2(1.5, 1.5), _third_table_position.position, 0)

	if table_cards.size() >= 4:
		_create_card(Vector2(1.5, 1.5), _fourth_table_position.position, 0, table_cards[3])
	else:
		_create_face_down_card(Vector2(1.5, 1.5), _fourth_table_position.position, 0)

	if table_cards.size() >= 5:
		_create_card(Vector2(1.5, 1.5), _fifth_table_position.position, 0, table_cards[4])
	else:
		_create_face_down_card(Vector2(1.5, 1.5), _fifth_table_position.position, 0)

puppetsync func _set_player_cards(player_cards: Array):
	_create_card(Vector2(3, 3), _second_player_position.position, -15, player_cards[0])
	_create_card(Vector2(3, 3), _first_player_position.position, 15, player_cards[1])

puppetsync func _set_turn():
	_check_button.disabled = false
	_fold_button.disabled = false
	_turn_timer.start()


func _on_TurnTimer_timeout():
	_check_button.disabled = true
	_fold_button.disabled = true
	rpc("_send_action", Plays.Fold)


func _on_FoldButton_pressed():
	_check_button.disabled = true
	_fold_button.disabled = true
	rpc("_send_action", Plays.FOLD)


func _on_CheckButton_pressed():
	_check_button.disabled = true
	_fold_button.disabled = true
	rpc("_send_action", Plays.CHECK)


func _create_face_down_card(scale: Vector2, position: Vector2, rotation: int) -> void:
	var card: Card = _card.instance()
	add_child(card)
	card.scale = scale
	card.position = position
	card.rotation_degrees = rotation
	card.set_card_face_down()


func _create_card(scale: Vector2, position: Vector2, rotation: int, value: Dictionary) -> void:
	var card: Card = _card.instance()
	add_child(card)
	card.scale = scale
	card.position = position
	card.rotation_degrees = rotation
	card.set_card(value)
	_table_cards_api_values += card.get_api_value() + ","


func _determine_winner():
	var player_cards: Dictionary
	var player_hands: String = ""

	for player in _players.keys():
		player_hands += "&pc[]="
		for card in _players[player]["cards"]:
			player_hands += card + ","

	_http_request.request(
		(
			"https://api.pokerapi.dev/v1/winner/texas_holdem?cc="
			+ _table_cards_api_values
			+ player_hands
		)
	)


func _on_HTTPRequest_request_completed(
	_result: int, _response_code: int, _headers: PoolStringArray, body: PoolByteArray
) -> void:
	var winner = JSON.parse(body.get_string_from_utf8()).result["winners"][0]

	print(winner)
	print(_players)

	for player_id in _players.keys():
		if (
			winner["cards"].split(",")[0] == _players[player_id]["cards"][0]
			and winner["cards"].split(",")[1] == _players[player_id]["cards"][1]
		):
			print(NetworkManager.players.get(player_id) + " won with a " + winner["result"])
