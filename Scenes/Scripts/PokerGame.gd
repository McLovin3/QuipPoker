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


func _ready():
	var first_card = _card.instance()
	add_child(first_card)
	first_card.set_card(GameManager.get_next_card())
	first_card.scale = Vector2(1.5, 1.5)
	first_card.position = _first_table_position.position
	_cards.append(first_card)

	var second_card = _card.instance()
	add_child(second_card)
	second_card.set_card(GameManager.get_next_card())
	second_card.scale = Vector2(1.5, 1.5)
	second_card.position = _second_table_position.position
	_cards.append(second_card)

	var third_card = _card.instance()
	add_child(third_card)
	third_card.set_card_back()
	third_card.scale = Vector2(1.5, 1.5)
	third_card.position = _third_table_position.position
	_cards.append(third_card)
	_unflipped_cards.append(third_card)

	var fourth_card = _card.instance()
	add_child(fourth_card)
	fourth_card.set_card_back()
	fourth_card.scale = Vector2(1.5, 1.5)
	fourth_card.position = _fourth_table_position.position
	_cards.append(fourth_card)
	_unflipped_cards.append(fourth_card)

	var fifth_card = _card.instance()
	add_child(fifth_card)
	fifth_card.set_card_back()
	fifth_card.scale = Vector2(1.5, 1.5)
	fifth_card.position = _fifth_table_position.position
	_cards.append(fifth_card)
	_unflipped_cards.append(fifth_card)

	var first_player_card = _card.instance()
	add_child(first_player_card)
	first_player_card.set_card(GameManager.get_next_card())
	first_player_card.scale = Vector2(3, 3)
	first_player_card.position = _second_player_position.position
	_cards.append(first_player_card)
	first_player_card.rotation_degrees = -15

	var second_player_card = _card.instance()
	add_child(second_player_card)
	second_player_card.set_card(GameManager.get_next_card())
	second_player_card.scale = Vector2(3, 3)
	second_player_card.position = _first_player_position.position
	_cards.append(second_player_card)
	second_player_card.rotation_degrees = 15


# func _check_hand() -> void:
# 	if _check_if_royal_flush():
# 		print("Royal Flush")


func _on_FoldButton_pressed():
	pass  # Replace with function body.


func _on_PassButton_pressed():
	if _turn <= 4:
		_unflipped_cards[_turn - 1].set_card(GameManager.get_next_card())
		_turn += 1

		if _turn == 4:
			_check_button.disabled = true

# func _check_if_royal_flush() -> bool:
# 	return (
# 		(
# 			_cards.has(GameManager.CardValues.ACE_OF_DIAMONDS)
# 			and _cards.has(GameManager.CardValues.KING_OF_DIAMONDS)
# 			and _cards.has(GameManager.CardValues.QUEEN_OF_DIAMONDS)
# 			and _cards.has(GameManager.CardValues.JACK_OF_DIAMONDS)
# 			and _cards.has(GameManager.CardValues.TEN_OF_DIAMONDS)
# 		)
# 		or (
# 			_cards.has(GameManager.CardValues.ACE_OF_HEARTS)
# 			and _cards.has(GameManager.CardValues.KING_OF_HEARTS)
# 			and _cards.has(GameManager.CardValues.QUEEN_OF_HEARTS)
# 			and _cards.has(GameManager.CardValues.JACK_OF_HEARTS)
# 			and _cards.has(GameManager.CardValues.TEN_OF_HEARTS)
# 		)
# 		or (
# 			_cards.has(GameManager.CardValues.ACE_OF_SPADES)
# 			and _cards.has(GameManager.CardValues.KING_OF_SPADES)
# 			and _cards.has(GameManager.CardValues.QUEEN_OF_SPADES)
# 			and _cards.has(GameManager.CardValues.JACK_OF_SPADES)
# 			and _cards.has(GameManager.CardValues.TEN_OF_SPADES)
# 		)
# 		or (
# 			_cards.has(GameManager.CardValues.ACE_OF_CLUBS)
# 			and _cards.has(GameManager.CardValues.KING_OF_CLUBS)
# 			and _cards.has(GameManager.CardValues.QUEEN_OF_CLUBS)
# 			and _cards.has(GameManager.CardValues.JACK_OF_CLUBS)
# 			and _cards.has(GameManager.CardValues.TEN_OF_CLUBS)
# 		)
# 	)
