extends Sprite

export var card_value : Texture

onready var _card_value : Sprite = $CardValue

func _ready():
	if (card_value):
		_card_value.texture = card_value
