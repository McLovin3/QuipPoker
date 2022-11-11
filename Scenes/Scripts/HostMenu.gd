extends CanvasLayer
class_name HostMenu

onready var _name_list: ItemList = $NameList
onready var _ip_address_label: Label = $IpAddress

var _names: PoolStringArray = []


func _ready():
	NetworkManager.connect("player_joined", self, "_player_connected")
	NetworkManager.connect("player_left", self, "_player_disconnected")
	_ip_address_label.text = "IP Address: " + NetworkManager.get_ip_address()
	_name_list.add_item(NetworkManager.get_username() + " (You) (Host)", null, false)
	_names.append(NetworkManager.get_username())


func _player_disconnected(username: String):
	_name_list.remove_item(_names.find(username))
	_names.remove(_names.find(username))


func _player_connected(username: String, _isHost: bool) -> void:
	_name_list.add_item(username, null, false)
	_names.append(username)


func _on_GoBackButton_pressed():
	NetworkManager.close_server()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_StartButton_pressed():
	if _name_list.get_item_count() > 0:
		pass
