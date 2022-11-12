extends CanvasLayer
class_name PokerGame

var _card: PackedScene = preload("res://Card/Card.tscn")
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

var _table_cards: Array = []
var _player_cards: Array = []
var _turn: int = 1


func _create_card(scale: Vector2, position: Vector2, rotation: int, is_face_down: bool) -> Card:
	var card: Card = _card.instance()
	add_child(card)
	card.scale = scale
	card.position = position
	card.rotation_degrees = rotation

	if is_face_down:
		card.set_card_face_down()

	else:
		card.set_card(GameManager.get_next_card())

	return card


func _create_table_cards() -> void:
	_table_cards.append_array(
		[
			_create_card(Vector2(1.5, 1.5), _first_table_position.position, 0, false),
			_create_card(Vector2(1.5, 1.5), _second_table_position.position, 0, false),
			_create_card(Vector2(1.5, 1.5), _third_table_position.position, 0, true),
			_create_card(Vector2(1.5, 1.5), _fourth_table_position.position, 0, true),
			_create_card(Vector2(1.5, 1.5), _fifth_table_position.position, 0, true)
		]
	)


func _create_player_cards() -> void:
	_player_cards.append_array(
		[
			_create_card(Vector2(3, 3), _second_player_position.position, -15, false),
			_create_card(Vector2(3, 3), _first_player_position.position, 15, false)
		]
	)


func _ready():
	_init_table()


func _init_table() -> void:
	GameManager.new_deck()
	_check_button.disabled = false
	_player_cards.clear()
	_table_cards.clear()
	_turn = 1

	_create_table_cards()
	_create_player_cards()

	print(_player_cards)
	print(_table_cards)


func _on_FoldButton_pressed():
	for card in _table_cards:
		if card.is_face_down():
			card.flip_card()

	var _player_cards_values = ""

	for i in range(_player_cards.size()):
		if i == _player_cards.size() - 1:
			_player_cards_values += _player_cards[i].get_api_value()
		else:
			_player_cards_values += _player_cards[i].get_api_value() + ","

	var _table_cards_values = ""

	for i in range(_table_cards.size()):
		if i == _table_cards.size() - 1:
			_table_cards_values += _table_cards[i].get_api_value()
		else:
			_table_cards_values += _table_cards[i].get_api_value() + ","

	$HTTPRequest.request(
		(
			"https://api.pokerapi.dev/v1/winner/texas_holdem?cc="
			+ _table_cards_values
			+ "&pc[]="
			+ _player_cards_values
		)
	)


func _on_PassButton_pressed():
	pass


func _on_HTTPRequest_request_completed(
	_result: int, _response_code: int, _headers: PoolStringArray, body: PoolByteArray
) -> void:
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
