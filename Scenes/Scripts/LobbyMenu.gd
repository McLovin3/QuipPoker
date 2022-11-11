extends CanvasLayer

onready var _name_list: ItemList = $NameList

var _names: PoolStringArray = []


func _ready():
	NetworkManager.connect("player_joined", self, "_player_connected")
	NetworkManager.connect("player_left", self, "_player_disconnected")
	get_tree().connect("server_disconnected", self, "_lobby_closed")
	_name_list.add_item(NetworkManager.get_username() + " (You)", null, false)
	_names.append(NetworkManager.get_username())


func _lobby_closed() -> void:
	NetworkManager.close_client()
	get_tree().change_scene("res://Scenes/JoinMenu.tscn")


func _player_disconnected(username: String) -> void:
	_name_list.remove_item(_names.find(username))
	_names.remove(_names.find(username))


func _player_connected(username: String, isHost: bool) -> void:
	if isHost:
		_name_list.add_item(username + " (Host)", null, false)
	else:
		_name_list.add_item(username, null, false)
	_names.append(username)


func _on_ExitButton_pressed() -> void:
	NetworkManager.close_client()
	get_tree().change_scene("res://Scenes/JoinMenu.tscn")
