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

onready var _check_button: Button = $CheckButton
onready var _fold_button: Button = $FoldButton

var _turn: int = 1
var _cards: Array = []
var _unflipped_cards: Array = []


func _create_card(position: Position2D, scale: Vector2, rotation: int, isHidden: bool):
	var card = _card.instance()
	add_child(card)

	if isHidden:
		card.set_card_back()
		_unflipped_cards.append(card)

	else:
		card.set_card(GameManager.get_next_card())
		_cards.append(card)

	card.scale = scale
	card.rotation_degrees = rotation
	card.position = position.position


func _ready():
	_init_table()


func _init_table() -> void:
	GameManager.new_deck()
	_check_button.disabled = false
	_turn = 1
	_cards.clear()
	_unflipped_cards.clear()

	_create_card(_first_table_position, Vector2(1.5, 1.5), 0, false)
	_create_card(_second_table_position, Vector2(1.5, 1.5), 0, false)
	_create_card(_third_table_position, Vector2(1.5, 1.5), 0, true)
	_create_card(_fourth_table_position, Vector2(1.5, 1.5), 0, true)
	_create_card(_fifth_table_position, Vector2(1.5, 1.5), 0, true)

	_create_card(_second_player_position, Vector2(3, 3), -15, false)
	_create_card(_first_player_position, Vector2(3, 3), 15, false)


# func _check_hand() -> void:
# 	if _check_if_royal_flush():
# 		print("Royal Flush")


func _on_FoldButton_pressed():
	_init_table()


func _on_PassButton_pressed():
	if _turn <= 4:
		var card = _unflipped_cards.pop_front()
		card.set_card(GameManager.get_next_card())
		_cards.append(card)
		_turn += 1

		if _turn == 4:
			_check_button.disabled = true
