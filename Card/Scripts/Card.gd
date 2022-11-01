extends Node2D

export var card_foreground: Texture
export var card_background: Texture

onready var _card_foreground_sprite: Sprite = $CardForeground
onready var _card_background_sprite: Sprite = $CardBackground


func _ready():
	if card_foreground:
		_card_foreground_sprite.texture = card_foreground

	if card_background:
		_card_background_sprite.texture = card_background
