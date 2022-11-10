extends Node2D
class_name Card

export var card_foreground: Texture
export var card_background: Texture

onready var _card_foreground_sprite: Sprite = $CardForeground
onready var _card_background_sprite: Sprite = $CardBackground

var _heart_path: String = "res://Card/Sprites/Hearts.png"
var _diamond_path: String = "res://Card/Sprites/Diamonds/"
var _spade_path: String = "res://Card/Sprites/Spades/"
var _club_path: String = "res://Card/Sprites/Clubs/"
var _faces_path: String = "res://Card/Sprites/Faces/"

enum CardValues {
	TWO_OF_HEARTS,
	THREE_OF_HEARTS,
	FOUR_OF_HEARTS,
	FIVE_OF_HEARTS,
	SIX_OF_HEARTS,
	SEVEN_OF_HEARTS,
	EIGHT_OF_HEARTS,
	NINE_OF_HEARTS,
	TEN_OF_HEARTS,
	JACK_OF_HEARTS,
	QUEEN_OF_HEARTS,
	KING_OF_HEARTS,
	ACE_OF_HEARTS,
	TWO_OF_SPADES,
	THREE_OF_SPADES,
	FOUR_OF_SPADES,
	FIVE_OF_SPADES,
	SIX_OF_SPADES,
	SEVEN_OF_SPADES,
	EIGHT_OF_SPADES,
	NINE_OF_SPADES,
	TEN_OF_SPADES,
	JACK_OF_SPADES,
	QUEEN_OF_SPADES,
	KING_OF_SPADES,
	ACE_OF_SPADES,
	TWO_OF_CLUBS,
	THREE_OF_CLUBS,
	FOUR_OF_CLUBS,
	FIVE_OF_CLUBS,
	SIX_OF_CLUBS,
	SEVEN_OF_CLUBS,
	EIGHT_OF_CLUBS,
	NINE_OF_CLUBS,
	TEN_OF_CLUBS,
	JACK_OF_CLUBS,
	QUEEN_OF_CLUBS,
	KING_OF_CLUBS,
	ACE_OF_CLUBS,
	TWO_OF_DIAMONDS,
	THREE_OF_DIAMONDS,
	FOUR_OF_DIAMONDS,
	FIVE_OF_DIAMONDS,
	SIX_OF_DIAMONDS,
	SEVEN_OF_DIAMONDS,
	EIGHT_OF_DIAMONDS,
	NINE_OF_DIAMONDS,
	TEN_OF_DIAMONDS,
	JACK_OF_DIAMONDS,
	QUEEN_OF_DIAMONDS,
	KING_OF_DIAMONDS,
	ACE_OF_DIAMONDS,
	BACK_OF_CARD
}


func _ready():
	if card_foreground:
		_card_foreground_sprite.texture = card_foreground

	if card_background:
		_card_background_sprite.texture = card_background


func set_card_value(cardValue: String) -> void:
	match cardValue:
		CardValues.ACE_OF_HEARTS:
			card_foreground = load(_heart_path + "AceOfHearts.png")
		CardValues.TWO_OF_HEARTS:
			card_foreground = load(_heart_path + "TwoOfHeats.png")
		CardValues.THREE_OF_HEARTS:
			card_foreground = load(_heart_path + "ThreeOfHearts.png")
		CardValues.FOUR_OF_HEARTS:
			card_foreground = load(_heart_path + "FourOfHearts.png")
		CardValues.FIVE_OF_HEARTS:
			card_foreground = load(_heart_path + "FiveOfHearts.png")
		CardValues.SIX_OF_HEARTS:
			card_foreground = load(_heart_path + "SixOfHearts.png")
		CardValues.SEVEN_OF_HEARTS:
			card_foreground = load(_heart_path + "SevenOfHearts.png")
		CardValues.EIGHT_OF_HEARTS:
			card_foreground = load(_heart_path + "EightOfHearts.png")
		CardValues.NINE_OF_HEARTS:
			card_foreground = load(_heart_path + "NineOfHearts.png")
		CardValues.TEN_OF_HEARTS:
			card_foreground = load(_heart_path + "TenOfHearts.png")
		CardValues.JACK_OF_HEARTS:
			card_background = load(_faces_path + "Jack.png")
			card_foreground = load(_heart_path + "JackOfHearts.png")
		CardValues.QUEEN_OF_HEARTS:
			card_background = load(_faces_path + "Queen.png")
			card_foreground = load(_heart_path + "QueenOfHearts.png")
		CardValues.KING_OF_HEARTS:
			card_background = load(_faces_path + "King.png")
			card_foreground = load(_heart_path + "KingOfHearts.png")
		CardValues.ACE_OF_SPADES:
			card_foreground = load(_spade_path + "AceOfSpades.png")
		CardValues.TWO_OF_SPADES:
			card_foreground = load(_spade_path + "TwoOfSpades.png")
		CardValues.THREE_OF_SPADES:
			card_foreground = load(_spade_path + "ThreeOfSpades.png")
		CardValues.FOUR_OF_SPADES:
			card_foreground = load(_spade_path + "FourOfSpades.png")
		CardValues.FIVE_OF_SPADES:
			card_foreground = load(_spade_path + "FiveOfSpades.png")
		CardValues.SIX_OF_SPADES:
			card_foreground = load(_spade_path + "SixOfSpades.png")
		CardValues.SEVEN_OF_SPADES:
			card_foreground = load(_spade_path + "SevenOfSpades.png")
		CardValues.EIGHT_OF_SPADES:
			card_foreground = load(_spade_path + "EightOfSpades.png")
		CardValues.NINE_OF_SPADES:
			card_foreground = load(_spade_path + "NineOfSpades.png")
		CardValues.TEN_OF_SPADES:
			card_foreground = load(_spade_path + "TenOfSpades.png")
		CardValues.JACK_OF_SPADES:
			card_background = load(_faces_path + "Jack.png")
			card_foreground = load(_spade_path + "JackOfSpades.png")
		CardValues.QUEEN_OF_SPADES:
			card_background = load(_faces_path + "Queen.png")
			card_foreground = load(_spade_path + "QueenOfSpades.png")
		CardValues.KING_OF_SPADES:
			card_background = load(_faces_path + "King.png")
			card_foreground = load(_spade_path + "KingOfSpades.png")
		CardValues.ACE_OF_CLUBS:
			card_foreground = load(_club_path + "AceOfClubs.png")
		CardValues.TWO_OF_CLUBS:
			card_foreground = load(_club_path + "TwoOfClubs.png")
		CardValues.THREE_OF_CLUBS:
			card_foreground = load(_club_path + "ThreeOfClubs.png")
		CardValues.FOUR_OF_CLUBS:
			card_foreground = load(_club_path + "FourOfClubs.png")
		CardValues.FIVE_OF_CLUBS:
			card_foreground = load(_club_path + "FiveOfClubs.png")
		CardValues.SIX_OF_CLUBS:
			card_foreground = load(_club_path + "SixOfClubs.png")
		CardValues.SEVEN_OF_CLUBS:
			card_foreground = load(_club_path + "SevenOfClubs.png")
		CardValues.EIGHT_OF_CLUBS:
			card_foreground = load(_club_path + "EightOfClubs.png")
		CardValues.NINE_OF_CLUBS:
			card_foreground = load(_club_path + "NineOfClubs.png")
		CardValues.TEN_OF_CLUBS:
			card_foreground = load(_club_path + "TenOfClubs.png")
		CardValues.JACK_OF_CLUBS:
			card_background = load(_faces_path + "Jack.png")
			card_foreground = load(_club_path + "JackOfClubs.png")
		CardValues.QUEEN_OF_CLUBS:
			card_background = load(_faces_path + "Queen.png")
			card_foreground = load(_club_path + "QueenOfClubs.png")
		CardValues.KING_OF_CLUBS:
			card_background = load(_faces_path + "King.png")
			card_foreground = load(_club_path + "KingOfClubs.png")
		CardValues.ACE_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "AceOfDiamonds.png")
		CardValues.TWO_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "TwoOfDiamonds.png")
		CardValues.THREE_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "ThreeOfDiamonds.png")
		CardValues.FOUR_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "FourOfDiamonds.png")
		CardValues.FIVE_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "FiveOfDiamonds.png")
		CardValues.SIX_OF_DIAMONDS:	
			card_foreground = load(_diamond_path + "SixOfDiamonds.png")
		CardValues.SEVEN_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "SevenOfDiamonds.png")
		CardValues.EIGHT_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "EightOfDiamonds.png")
		CardValues.NINE_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "NineOfDiamonds.png")
		CardValues.TEN_OF_DIAMONDS:
			card_foreground = load(_diamond_path + "TenOfDiamonds.png")
		CardValues.JACK_OF_DIAMONDS:
			card_background = load(_faces_path + "Jack.png")
			card_foreground = load(_diamond_path + "JackOfDiamonds.png")
		CardValues.QUEEN_OF_DIAMONDS:
			card_background = load(_faces_path + "Queen.png")
			card_foreground = load(_diamond_path + "QueenOfDiamonds.png")
		CardValues.KING_OF_DIAMONDS:
			card_background = load(_faces_path + "King.png")
			card_foreground = load(_diamond_path + "KingOfDiamonds.png")
		CardValues.BACK_OF_CARD:
			card_background = load("res://Card/Sprites/CardBack.png")
			card_foreground = load("res://Card/Sprites/CardBackDetails.png")