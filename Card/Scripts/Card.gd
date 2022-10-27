extends Sprite

export var card_value : Texture
export var card_background : Texture

onready var _card_value_sprite : Sprite = $CardValue
onready var _card_background_sprite : Sprite = $CardBackground

func _ready():
	if (card_value):
		_card_value_sprite.texture = card_value
	
	if (card_background):
		_card_background_sprite.texture = card_background
