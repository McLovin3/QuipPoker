extends Node2D
class_name CardManager

var _card: PackedScene = preload("res://Card/Card.tscn")

onready var _first_table_card_position: Position2D = $TableCard1
onready var _second_table_card_position: Position2D = $TableCard2
onready var _third_table_card_position: Position2D = $TableCard3
onready var _fourth_table_card_position: Position2D = $TableCard4
onready var _fifth_table_card_position: Position2D = $TableCard5

onready var _first_player_card_position: Position2D = $PlayerCard1
onready var _second_player_card_position: Position2D = $PlayerCard2

var _player_positions: Array = []
var _table_positions: Array = []
var _player_hand: Array = []
var _table_hand: Array = []
var _unflipped_table_hand: Array = []


func _ready() -> void:
	_table_positions.append_array(
		[
			_first_table_card_position,
			_second_table_card_position,
			_third_table_card_position,
			_fourth_table_card_position,
			_fifth_table_card_position
		]
	)

	_player_positions.append_array([_first_player_card_position, _second_player_card_position])


func get_table_hand_api_values() -> String:
	var table_hand_api_values: String = "cc="

	for card in _table_hand:
		table_hand_api_values += card.get_api_value() + ","

	return table_hand_api_values


func set_initial_player_cards(player_values: Array) -> void:
	_create_player_card(Vector2(3, 3), _player_positions[1].position, -15, player_values[0])
	_create_player_card(Vector2(3, 3), _player_positions[0].position, 15, player_values[1])

func set_initial_table_cards(table_values: Array) -> void:
	for i in range(2):
		_create_table_card(Vector2(1.5, 1.5), _table_positions[i].position, 0, table_values[i])

	for i in range(2, 5):
		_create_table_card(Vector2(1.5, 1.5), _table_positions[i].position, 0, null)


func flip_next_card(card_value: Dictionary) -> void:
	var card = _unflipped_table_hand.pop_front()

	if card != null:
		_table_hand.append(card)
		card.set_card(card_value)

func _create_player_card(scale: Vector2, position: Vector2, rotation: float, value: Dictionary) -> void:
	var card: Card = _card.instance()
	add_child(card)
	card.scale = scale
	card.position = position
	card.rotation_degrees = rotation

	card.set_card(value)
	_player_hand.append(card)

func _create_table_card(scale: Vector2, position: Vector2, rotation: int, value) -> void:
	var card: Card = _card.instance()
	add_child(card)
	card.scale = scale
	card.position = position
	card.rotation_degrees = rotation

	if value == null:
		card.set_card_face_down()
		_unflipped_table_hand.append(card)

	else:
		card.set_card(value)
		_table_hand.append(card)
