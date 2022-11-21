extends CanvasLayer
class_name LobbyMenu

onready var _name_list: ItemList = $NameList
onready var _ip_address_label: Label = $IpAddress
onready var _start_button: Button = $StartButton

var _is_host: bool
var _names: PoolStringArray = []


func _ready():
	_is_host = get_tree().is_network_server()

	if _is_host:
		_name_list.add_item(NetworkManager.get_username() + " (You) (Host)", null, false)
		_ip_address_label.text = "IP Address: " + NetworkManager.get_ip_address()
	else:
		_name_list.add_item(NetworkManager.get_username() + " (You)", null, false)
		_start_button.visible = false
		_ip_address_label.visible = false

	NetworkManager.connect("player_joined", self, "_player_connected")
	NetworkManager.connect("player_left", self, "_player_disconnected")
	_names.append(NetworkManager.get_username())


func _player_disconnected(username: String) -> void:
	_name_list.remove_item(_names.find(username))
	_names.remove(_names.find(username))

	if _names.size() < 3:
		_start_button.disabled = true

func _player_connected(username: String, player_is_host: bool) -> void:
	if player_is_host:
		_name_list.add_item(username + " (Host)", null, false)
	else:
		_name_list.add_item(username, null, false)
	_names.append(username)

	if _names.size() >= 3:
		_start_button.disabled = false


func _on_ExitButton_pressed() -> void:
	if _is_host:
		NetworkManager.close_server()
	else:
		NetworkManager.close_client()

	get_tree().change_scene("res://Scenes/MainMenu.tscn")


puppetsync func _start_game() -> void:
	get_tree().change_scene("res://Scenes/PokerGame.tscn")


func _on_StartButton_pressed():
	rpc("_start_game")
