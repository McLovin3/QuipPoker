extends CanvasLayer

onready var _name_list: ItemList = $NameList

var _names: PoolStringArray = []


func _ready():
	GameManager.connect("player_joined", self, "_player_connected")
	GameManager.connect("player_left", self, "_player_disconnected")
	get_tree().connect("server_disconnected", self, "_lobby_closed")
	_name_list.add_item(GameManager.get_username() + " (You)", null, false)
	_names.append(GameManager.get_username())


func _lobby_closed():
	get_tree().change_scene("res://Scenes/JoinMenu.tscn")


func _player_disconnected(username: String):
	_name_list.remove_item(_names.find(username))
	_names.remove(_names.find(username))


func _player_connected(username: String) -> void:
	_name_list.add_item(username, null, false)
	_names.append(username)


func _on_ExitButton_pressed():
	GameManager.close_server()
	get_tree().change_scene("res://Scenes/JoinMenu.tscn")
