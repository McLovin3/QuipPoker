extends Node2D

export var port: int = 7777
export var max_clients: int = 6

onready var _connection_timer: Timer = $ConnectionTimer

var _peer: NetworkedMultiplayerENet
var _username: String = "" setget set_username, get_username
var _ip_address: String = "" setget , get_ip_address


func _ready():
	match OS.get_name():
		"Windows":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")), 1)
		"X11":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)
		"OSX":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)

	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")


func create_server() -> void:
	_peer = NetworkedMultiplayerENet.new()
	_peer.create_server(port, max_clients)
	get_tree().set_network_peer(_peer)


func join_server(ip_address: String) -> void:
	_peer = NetworkedMultiplayerENet.new()
	_peer.create_client(ip_address, port)
	get_tree().set_network_peer(_peer)
	_connection_timer.start()


func _connection_failed() -> void:
	print("Connection failed!")


func _connected_to_server():
	get_tree().change_scene("res://scenes/LobbyScene.tscn")
	print("Connected to server")


func _server_disconnected():
	print("Disconnected from server")


func get_ip_address() -> String:
	return _ip_address


func set_username(username: String) -> void:
	_username = username


func get_username() -> String:
	return _username


func _on_ConnectionTimer_timeout():
	if _peer.get_connection_status() == 1:
		_peer.emit_signal("connection_failed")
		_peer.close_connection()
