extends CanvasLayer
class_name HostMenu

onready var _name_list: ItemList = $NameList
onready var _ip_address_label: Label = $IpAddress

var _names: PoolStringArray = []


func _ready():
	GameManager.connect("player_joined", self, "_player_connected")
	GameManager.connect("player_left", self, "_player_disconnected")
	_ip_address_label.text = "IP Address: " + GameManager.get_ip_address()
	_name_list.add_item(GameManager.get_username() + " (You) (Host)", null, false)
	_names.append(GameManager.get_username())


func _player_disconnected(username: String):
	_name_list.remove_item(_names.find(username))
	_names.remove(_names.find(username))


func _player_connected(username: String) -> void:
	_name_list.add_item(username, null, false)
	_names.append(username)


func _on_GoBackButton_pressed():
	get_tree().network_peer.close_connection()
	print(get_tree().network_peer)
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_StartButton_pressed():
	if _name_list.get_item_count() > 0:
		pass
