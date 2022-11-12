extends Node2D

enum Suits { HEARTS, DIAMONDS, SPADES, CLUBS }
enum Values { ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }

var _deck: Array = []


func _ready():
	new_deck()


func new_deck() -> void:
	_deck.clear()
	for suit in Suits.values():
		for value in Values.values():
			_deck.append({"suit": suit, "value": value})

	randomize()
	_deck.shuffle()


func get_next_card() -> Dictionary:
	return _deck.pop_front()
