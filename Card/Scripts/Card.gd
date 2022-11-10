extends Node2D
class_name Card

onready var _card_foreground_sprite: Sprite = $CardForeground
onready var _card_background_sprite: Sprite = $CardBackground

var _heart_path: String = "res://Card/Sprites/Hearts.png"
var _diamond_path: String = "res://Card/Sprites/Diamonds/"
var _spade_path: String = "res://Card/Sprites/Spades/"
var _club_path: String = "res://Card/Sprites/Clubs/"
var _faces_path: String = "res://Card/Sprites/Faces/"


func set_card_value(cardValue: int) -> void:
	match cardValue:
		GameManager.CardValues.ACE_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "AceOfHearts.png")
		GameManager.CardValues.TWO_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "TwoOfHeats.png")
		GameManager.CardValues.THREE_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "ThreeOfHearts.png")
		GameManager.CardValues.FOUR_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "FourOfHearts.png")
		GameManager.CardValues.FIVE_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "FiveOfHearts.png")
		GameManager.CardValues.SIX_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "SixOfHearts.png")
		GameManager.CardValues.SEVEN_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "SevenOfHearts.png")
		GameManager.CardValues.EIGHT_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "EightOfHearts.png")
		GameManager.CardValues.NINE_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "NineOfHearts.png")
		GameManager.CardValues.TEN_OF_HEARTS:
			_card_foreground_sprite.texture = load(_heart_path + "TenOfHearts.png")
		GameManager.CardValues.JACK_OF_HEARTS:
			_card_background_sprite.texture = load(_faces_path + "Jack.png")
			_card_foreground_sprite.texture = load(_heart_path + "JackOfHearts.png")
		GameManager.CardValues.QUEEN_OF_HEARTS:
			_card_background_sprite.texture = load(_faces_path + "Queen.png")
			_card_foreground_sprite.texture = load(_heart_path + "QueenOfHearts.png")
		GameManager.CardValues.KING_OF_HEARTS:
			_card_background_sprite.texture = load(_faces_path + "King.png")
			_card_foreground_sprite.texture = load(_heart_path + "KingOfHearts.png")
		GameManager.CardValues.ACE_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "AceOfSpades.png")
		GameManager.CardValues.TWO_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "TwoOfSpades.png")
		GameManager.CardValues.THREE_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "ThreeOfSpades.png")
		GameManager.CardValues.FOUR_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "FourOfSpades.png")
		GameManager.CardValues.FIVE_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "FiveOfSpades.png")
		GameManager.CardValues.SIX_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "SixOfSpades.png")
		GameManager.CardValues.SEVEN_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "SevenOfSpades.png")
		GameManager.CardValues.EIGHT_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "EightOfSpades.png")
		GameManager.CardValues.NINE_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "NineOfSpades.png")
		GameManager.CardValues.TEN_OF_SPADES:
			_card_foreground_sprite.texture = load(_spade_path + "TenOfSpades.png")
		GameManager.CardValues.JACK_OF_SPADES:
			_card_background_sprite.texture = load(_faces_path + "Jack.png")
			_card_foreground_sprite.texture = load(_spade_path + "JackOfSpades.png")
		GameManager.CardValues.QUEEN_OF_SPADES:
			_card_background_sprite.texture = load(_faces_path + "Queen.png")
			_card_foreground_sprite.texture = load(_spade_path + "QueenOfSpades.png")
		GameManager.CardValues.KING_OF_SPADES:
			_card_background_sprite.texture = load(_faces_path + "King.png")
			_card_foreground_sprite.texture = load(_spade_path + "KingOfSpades.png")
		GameManager.CardValues.ACE_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "AceOfClubs.png")
		GameManager.CardValues.TWO_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "TwoOfClubs.png")
		GameManager.CardValues.THREE_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "ThreeOfClubs.png")
		GameManager.CardValues.FOUR_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "FourOfClubs.png")
		GameManager.CardValues.FIVE_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "FiveOfClubs.png")
		GameManager.CardValues.SIX_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "SixOfClubs.png")
		GameManager.CardValues.SEVEN_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "SevenOfClubs.png")
		GameManager.CardValues.EIGHT_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "EightOfClubs.png")
		GameManager.CardValues.NINE_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "NineOfClubs.png")
		GameManager.CardValues.TEN_OF_CLUBS:
			_card_foreground_sprite.texture = load(_club_path + "TenOfClubs.png")
		GameManager.CardValues.JACK_OF_CLUBS:
			_card_background_sprite.texture = load(_faces_path + "Jack.png")
			_card_foreground_sprite.texture = load(_club_path + "JackOfClubs.png")
		GameManager.CardValues.QUEEN_OF_CLUBS:
			_card_background_sprite.texture = load(_faces_path + "Queen.png")
			_card_foreground_sprite.texture = load(_club_path + "QueenOfClubs.png")
		GameManager.CardValues.KING_OF_CLUBS:
			_card_background_sprite.texture = load(_faces_path + "King.png")
			_card_foreground_sprite.texture = load(_club_path + "KingOfClubs.png")
		GameManager.CardValues.ACE_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "AceOfDiamonds.png")
		GameManager.CardValues.TWO_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "TwoOfDiamonds.png")
		GameManager.CardValues.THREE_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "ThreeOfDiamonds.png")
		GameManager.CardValues.FOUR_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "FourOfDiamonds.png")
		GameManager.CardValues.FIVE_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "FiveOfDiamonds.png")
		GameManager.CardValues.SIX_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "SixOfDiamonds.png")
		GameManager.CardValues.SEVEN_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "SevenOfDiamonds.png")
		GameManager.CardValues.EIGHT_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "EightOfDiamonds.png")
		GameManager.CardValues.NINE_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "NineOfDiamonds.png")
		GameManager.CardValues.TEN_OF_DIAMONDS:
			_card_foreground_sprite.texture = load(_diamond_path + "TenOfDiamonds.png")
		GameManager.CardValues.JACK_OF_DIAMONDS:
			_card_background_sprite.texture = load(_faces_path + "Jack.png")
			_card_foreground_sprite.texture = load(_diamond_path + "JackOfDiamonds.png")
		GameManager.CardValues.QUEEN_OF_DIAMONDS:
			_card_background_sprite.texture = load(_faces_path + "Queen.png")
			_card_foreground_sprite.texture = load(_diamond_path + "QueenOfDiamonds.png")
		GameManager.CardValues.KING_OF_DIAMONDS:
			_card_background_sprite.texture = load(_faces_path + "King.png")
			_card_foreground_sprite.texture = load(_diamond_path + "KingOfDiamonds.png")
		GameManager.CardValues.BACK_OF_CARD:
			_card_background_sprite.texture = load("res://Card/Sprites/CardBack.png")
			_card_foreground_sprite.texture = load("res://Card/Sprites/CardBackDetails.png")
		_:
			print("Card value not found")
