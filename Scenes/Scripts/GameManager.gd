extends Node2D

signal player_joined(username, isHost)
signal player_left(username)

export var port: int = 7777
export var max_clients: int = 6

onready var _connection_timer: Timer = $ConnectionTimer

var _peer: NetworkedMultiplayerENet
var _username: String = "" setget set_username, get_username
var _ip_address: String = "" setget , get_ip_address
var players: Dictionary = {}


func _ready():
	match OS.get_name():
		"Windows":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")), 1)
		"X11":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)
		"OSX":
			_ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)

	#Server signals
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

	#Client signals
	get_tree().connect("connected_to_server", self, "_connected_to_server")


# Server functions
func create_server() -> void:
	_peer = NetworkedMultiplayerENet.new()
	_peer.create_server(port, max_clients)
	get_tree().set_network_peer(_peer)


func _player_connected(id: int) -> void:
	rpc_id(id, "_register_player", _username)


func _player_disconnected(id: int) -> void:
	emit_signal("player_left", players[id])
	players.erase(id)


func close_server() -> void:
	if _peer:
		_peer.close_connection()
		get_tree().set_network_peer(null)


remote func _register_player(username: String) -> void:
	players[get_tree().get_rpc_sender_id()] = username
	emit_signal("player_joined", username, get_tree().get_rpc_sender_id() == 1)


# Client functions


func join_server(ip_address: String) -> void:
	_peer = NetworkedMultiplayerENet.new()
	_peer.create_client(ip_address, port)
	get_tree().set_network_peer(_peer)
	_connection_timer.start()


func _connected_to_server() -> void:
	get_tree().change_scene("res://scenes/LobbyMenu.tscn")


func close_client() -> void:
	if _peer:
		_peer.close_connection()
		get_tree().set_network_peer(null)


#General functions


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
