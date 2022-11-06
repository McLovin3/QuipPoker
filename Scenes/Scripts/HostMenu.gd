extends CanvasLayer
class_name HostMenu

onready var _name_list: ItemList = $NameList


func _ready():
	_name_list.add_item(GameManager.get_username() + " (You)", null, false)


func _on_GoBackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_NeonButton_pressed():
	if _name_list.get_item_count() > 0:
		pass
