extends Node2D

onready var _card_foreground_sprite: Sprite = $CardForeground
onready var _card_background_sprite: Sprite = $CardBackground

var _suit: int setget , get_suit
var _value: int setget , get_value

var _heart_path: String = "res://Card/Sprites/Hearts/"
var _diamond_path: String = "res://Card/Sprites/Diamonds/"
var _spade_path: String = "res://Card/Sprites/Spades/"
var _club_path: String = "res://Card/Sprites/Clubs/"
var _faces_path: String = "res://Card/Sprites/Faces/"


func get_suit() -> int:
	return _suit


func get_value() -> int:
	return _value


func _set_foreground(path: String, value: int) -> void:
	_value = value
	_card_foreground_sprite.texture = load(path)


func _set_background(path: String) -> void:
	_card_background_sprite.texture = load(path)


func set_card_back() -> void:
	_card_foreground_sprite.texture = load("res://Card/Sprites/CardBackDetails.png")
	_card_background_sprite.texture = load("res://Card/Sprites/CardBack.png")


func set_card(card_value: Dictionary) -> void:
	_card_foreground_sprite.texture = null
	_card_background_sprite.texture = null

	var suit = card_value["suit"]
	var value = card_value["value"]

	match suit:
		GameManager.Suits.HEARTS:
			_suit = suit
			match value:
				GameManager.Values.ACE:
					_set_foreground(_heart_path + "AceOfHearts.png", value)
				GameManager.Values.TWO:
					_set_foreground(_heart_path + "TwoOfHearts.png", value)
				GameManager.Values.THREE:
					_set_foreground(_heart_path + "ThreeOfHearts.png", value)
				GameManager.Values.FOUR:
					_set_foreground(_heart_path + "FourOfHearts.png", value)
				GameManager.Values.FIVE:
					_set_foreground(_heart_path + "FiveOfHearts.png", value)
				GameManager.Values.SIX:
					_set_foreground(_heart_path + "SixOfHearts.png", value)
				GameManager.Values.SEVEN:
					_set_foreground(_heart_path + "SevenOfHearts.png", value)
				GameManager.Values.EIGHT:
					_set_foreground(_heart_path + "EightOfHearts.png", value)
				GameManager.Values.NINE:
					_set_foreground(_heart_path + "NineOfHearts.png", value)
				GameManager.Values.TEN:
					_set_foreground(_heart_path + "TenOfHearts.png", value)
				GameManager.Values.JACK:
					_set_foreground(_heart_path + "JackOfHearts.png", value)
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_set_foreground(_heart_path + "QueenOfHearts.png", value)
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_set_foreground(_heart_path + "KingOfHearts.png", value)
					_set_background(_faces_path + "King.png")
		GameManager.Suits.DIAMONDS:
			_suit = suit
			match value:
				GameManager.Values.ACE:
					_set_foreground(_diamond_path + "AceOfDiamonds.png", value)
				GameManager.Values.TWO:
					_set_foreground(_diamond_path + "TwoOfDiamonds.png", value)
				GameManager.Values.THREE:
					_set_foreground(_diamond_path + "ThreeOfDiamonds.png", value)
				GameManager.Values.FOUR:
					_set_foreground(_diamond_path + "FourOfDiamonds.png", value)
				GameManager.Values.FIVE:
					_set_foreground(_diamond_path + "FiveOfDiamonds.png", value)
				GameManager.Values.SIX:
					_set_foreground(_diamond_path + "SixOfDiamonds.png", value)
				GameManager.Values.SEVEN:
					_set_foreground(_diamond_path + "SevenOfDiamonds.png", value)
				GameManager.Values.EIGHT:
					_set_foreground(_diamond_path + "EightOfDiamonds.png", value)
				GameManager.Values.NINE:
					_set_foreground(_diamond_path + "NineOfDiamonds.png", value)
				GameManager.Values.TEN:
					_set_foreground(_diamond_path + "TenOfDiamonds.png", value)
				GameManager.Values.JACK:
					_set_foreground(_diamond_path + "JackOfDiamonds.png", value)
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_set_foreground(_diamond_path + "QueenOfDiamonds.png", value)
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_set_foreground(_diamond_path + "KingOfDiamonds.png", value)
					_set_background(_faces_path + "King.png")
		GameManager.Suits.SPADES:
			_suit = suit
			match value:
				GameManager.Values.ACE:
					_set_foreground(_spade_path + "AceOfSpades.png", value)
				GameManager.Values.TWO:
					_set_foreground(_spade_path + "TwoOfSpades.png", value)
				GameManager.Values.THREE:
					_set_foreground(_spade_path + "ThreeOfSpades.png", value)
				GameManager.Values.FOUR:
					_set_foreground(_spade_path + "FourOfSpades.png", value)
				GameManager.Values.FIVE:
					_set_foreground(_spade_path + "FiveOfSpades.png", value)
				GameManager.Values.SIX:
					_set_foreground(_spade_path + "SixOfSpades.png", value)
				GameManager.Values.SEVEN:
					_set_foreground(_spade_path + "SevenOfSpades.png", value)
				GameManager.Values.EIGHT:
					_set_foreground(_spade_path + "EightOfSpades.png", value)
				GameManager.Values.NINE:
					_set_foreground(_spade_path + "NineOfSpades.png", value)
				GameManager.Values.TEN:
					_set_foreground(_spade_path + "TenOfSpades.png", value)
				GameManager.Values.JACK:
					_set_foreground(_spade_path + "JackOfSpades.png", value)
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_set_foreground(_spade_path + "QueenOfSpades.png", value)
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_set_foreground(_spade_path + "KingOfSpades.png", value)
					_set_background(_faces_path + "King.png")
		GameManager.Suits.CLUBS:
			_suit = suit
			match value:
				GameManager.Values.ACE:
					_set_foreground(_club_path + "AceOfClubs.png", value)
				GameManager.Values.TWO:
					_set_foreground(_club_path + "TwoOfClubs.png", value)
				GameManager.Values.THREE:
					_set_foreground(_club_path + "ThreeOfClubs.png", value)
				GameManager.Values.FOUR:
					_set_foreground(_club_path + "FourOfClubs.png", value)
				GameManager.Values.FIVE:
					_set_foreground(_club_path + "FiveOfClubs.png", value)
				GameManager.Values.SIX:
					_set_foreground(_club_path + "SixOfClubs.png", value)
				GameManager.Values.SEVEN:
					_set_foreground(_club_path + "SevenOfClubs.png", value)
				GameManager.Values.EIGHT:
					_set_foreground(_club_path + "EightOfClubs.png", value)
				GameManager.Values.NINE:
					_set_foreground(_club_path + "NineOfClubs.png", value)
				GameManager.Values.TEN:
					_set_foreground(_club_path + "TenOfClubs.png", value)
				GameManager.Values.JACK:
					_set_foreground(_club_path + "JackOfClubs.png", value)
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_set_foreground(_club_path + "QueenOfClubs.png", value)
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_set_foreground(_club_path + "KingOfClubs.png", value)
					_set_background(_faces_path + "King.png")
