extends Node2D
class_name Card

onready var _card_foreground_sprite: Sprite = $CardForeground
onready var _card_background_sprite: Sprite = $CardBackground

var _api_value: String setget , get_api_value
var _face_down: bool = false setget , is_face_down
var _heart_path: String = "res://Card/Sprites/Hearts/"
var _diamond_path: String = "res://Card/Sprites/Diamonds/"
var _spade_path: String = "res://Card/Sprites/Spades/"
var _club_path: String = "res://Card/Sprites/Clubs/"
var _faces_path: String = "res://Card/Sprites/Faces/"


func get_api_value() -> String:
	return _api_value


func is_face_down() -> bool:
	return _face_down


func flip_card() -> void:
	if _face_down:
		_face_down = false
		set_card(GameManager.get_next_card())


func set_card_face_down() -> void:
	_face_down = true
	_card_foreground_sprite.texture = load("res://Card/Sprites/CardBackDetails.png")
	_card_background_sprite.texture = load("res://Card/Sprites/CardBack.png")


func set_card(card_value: Dictionary) -> void:
	_card_foreground_sprite.texture = null
	_card_background_sprite.texture = null

	var suit = card_value["suit"]
	var value = card_value["value"]

	match suit:
		GameManager.Suits.HEARTS:
			match value:
				GameManager.Values.ACE:
					_api_value = "AH"
					_set_foreground(_heart_path + "AceOfHearts.png")
				GameManager.Values.TWO:
					_api_value = "2H"
					_set_foreground(_heart_path + "TwoOfHearts.png")
				GameManager.Values.THREE:
					_api_value = "3H"
					_set_foreground(_heart_path + "ThreeOfHearts.png")
				GameManager.Values.FOUR:
					_api_value = "4H"
					_set_foreground(_heart_path + "FourOfHearts.png")
				GameManager.Values.FIVE:
					_api_value = "5H"
					_set_foreground(_heart_path + "FiveOfHearts.png")
				GameManager.Values.SIX:
					_api_value = "6H"
					_set_foreground(_heart_path + "SixOfHearts.png")
				GameManager.Values.SEVEN:
					_api_value = "7H"
					_set_foreground(_heart_path + "SevenOfHearts.png")
				GameManager.Values.EIGHT:
					_api_value = "8H"
					_set_foreground(_heart_path + "EightOfHearts.png")
				GameManager.Values.NINE:
					_api_value = "9H"
					_set_foreground(_heart_path + "NineOfHearts.png")
				GameManager.Values.TEN:
					_api_value = "10H"
					_set_foreground(_heart_path + "TenOfHearts.png")
				GameManager.Values.JACK:
					_api_value = "JH"
					_set_foreground(_heart_path + "JackOfHearts.png")
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_api_value = "QH"
					_set_foreground(_heart_path + "QueenOfHearts.png")
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_api_value = "KH"
					_set_foreground(_heart_path + "KingOfHearts.png")
					_set_background(_faces_path + "King.png")
		GameManager.Suits.DIAMONDS:
			match value:
				GameManager.Values.ACE:
					_api_value = "AD"
					_set_foreground(_diamond_path + "AceOfDiamonds.png")
				GameManager.Values.TWO:
					_api_value = "2D"
					_set_foreground(_diamond_path + "TwoOfDiamonds.png")
				GameManager.Values.THREE:
					_api_value = "3D"
					_set_foreground(_diamond_path + "ThreeOfDiamonds.png")
				GameManager.Values.FOUR:
					_api_value = "4D"
					_set_foreground(_diamond_path + "FourOfDiamonds.png")
				GameManager.Values.FIVE:
					_api_value = "5D"
					_set_foreground(_diamond_path + "FiveOfDiamonds.png")
				GameManager.Values.SIX:
					_api_value = "6D"
					_set_foreground(_diamond_path + "SixOfDiamonds.png")
				GameManager.Values.SEVEN:
					_api_value = "7D"
					_set_foreground(_diamond_path + "SevenOfDiamonds.png")
				GameManager.Values.EIGHT:
					_api_value = "8D"
					_set_foreground(_diamond_path + "EightOfDiamonds.png")
				GameManager.Values.NINE:
					_api_value = "9D"
					_set_foreground(_diamond_path + "NineOfDiamonds.png")
				GameManager.Values.TEN:
					_api_value = "10D"
					_set_foreground(_diamond_path + "TenOfDiamonds.png")
				GameManager.Values.JACK:
					_api_value = "JD"
					_set_foreground(_diamond_path + "JackOfDiamonds.png")
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_api_value = "QD"
					_set_foreground(_diamond_path + "QueenOfDiamonds.png")
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_api_value = "KD"
					_set_foreground(_diamond_path + "KingOfDiamonds.png")
					_set_background(_faces_path + "King.png")
		GameManager.Suits.SPADES:
			match value:
				GameManager.Values.ACE:
					_api_value = "AS"
					_set_foreground(_spade_path + "AceOfSpades.png")
				GameManager.Values.TWO:
					_api_value = "2S"
					_set_foreground(_spade_path + "TwoOfSpades.png")
				GameManager.Values.THREE:
					_api_value = "3S"
					_set_foreground(_spade_path + "ThreeOfSpades.png")
				GameManager.Values.FOUR:
					_api_value = "4S"
					_set_foreground(_spade_path + "FourOfSpades.png")
				GameManager.Values.FIVE:
					_api_value = "5S"
					_set_foreground(_spade_path + "FiveOfSpades.png")
				GameManager.Values.SIX:
					_api_value = "6S"
					_set_foreground(_spade_path + "SixOfSpades.png")
				GameManager.Values.SEVEN:
					_api_value = "7S"
					_set_foreground(_spade_path + "SevenOfSpades.png")
				GameManager.Values.EIGHT:
					_api_value = "8S"
					_set_foreground(_spade_path + "EightOfSpades.png")
				GameManager.Values.NINE:
					_api_value = "9S"
					_set_foreground(_spade_path + "NineOfSpades.png")
				GameManager.Values.TEN:
					_api_value = "10S"
					_set_foreground(_spade_path + "TenOfSpades.png")
				GameManager.Values.JACK:
					_api_value = "JS"
					_set_foreground(_spade_path + "JackOfSpades.png")
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_api_value = "QS"
					_set_foreground(_spade_path + "QueenOfSpades.png")
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_api_value = "KS"
					_set_foreground(_spade_path + "KingOfSpades.png")
					_set_background(_faces_path + "King.png")
		GameManager.Suits.CLUBS:
			match value:
				GameManager.Values.ACE:
					_api_value = "AC"
					_set_foreground(_club_path + "AceOfClubs.png")
				GameManager.Values.TWO:
					_api_value = "2C"
					_set_foreground(_club_path + "TwoOfClubs.png")
				GameManager.Values.THREE:
					_api_value = "3C"
					_set_foreground(_club_path + "ThreeOfClubs.png")
				GameManager.Values.FOUR:
					_api_value = "4C"
					_set_foreground(_club_path + "FourOfClubs.png")
				GameManager.Values.FIVE:
					_api_value = "5C"
					_set_foreground(_club_path + "FiveOfClubs.png")
				GameManager.Values.SIX:
					_api_value = "6C"
					_set_foreground(_club_path + "SixOfClubs.png")
				GameManager.Values.SEVEN:
					_api_value = "7C"
					_set_foreground(_club_path + "SevenOfClubs.png")
				GameManager.Values.EIGHT:
					_api_value = "8C"
					_set_foreground(_club_path + "EightOfClubs.png")
				GameManager.Values.NINE:
					_api_value = "9C"
					_set_foreground(_club_path + "NineOfClubs.png")
				GameManager.Values.TEN:
					_api_value = "10C"
					_set_foreground(_club_path + "TenOfClubs.png")
				GameManager.Values.JACK:
					_api_value = "JC"
					_set_foreground(_club_path + "JackOfClubs.png")
					_set_background(_faces_path + "Jack.png")
				GameManager.Values.QUEEN:
					_api_value = "QC"
					_set_foreground(_club_path + "QueenOfClubs.png")
					_set_background(_faces_path + "Queen.png")
				GameManager.Values.KING:
					_api_value = "KC"
					_set_foreground(_club_path + "KingOfClubs.png")
					_set_background(_faces_path + "King.png")


func _set_foreground(path: String) -> void:
	_card_foreground_sprite.texture = load(path)


func _set_background(path: String) -> void:
	_card_background_sprite.texture = load(path)
