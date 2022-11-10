extends Node2D

enum CardValues {
	TWO_OF_HEARTS,
	THREE_OF_HEARTS,
	FOUR_OF_HEARTS,
	FIVE_OF_HEARTS,
	SIX_OF_HEARTS,
	SEVEN_OF_HEARTS,
	EIGHT_OF_HEARTS,
	NINE_OF_HEARTS,
	TEN_OF_HEARTS,
	JACK_OF_HEARTS,
	QUEEN_OF_HEARTS,
	KING_OF_HEARTS,
	ACE_OF_HEARTS,
	TWO_OF_SPADES,
	THREE_OF_SPADES,
	FOUR_OF_SPADES,
	FIVE_OF_SPADES,
	SIX_OF_SPADES,
	SEVEN_OF_SPADES,
	EIGHT_OF_SPADES,
	NINE_OF_SPADES,
	TEN_OF_SPADES,
	JACK_OF_SPADES,
	QUEEN_OF_SPADES,
	KING_OF_SPADES,
	ACE_OF_SPADES,
	TWO_OF_CLUBS,
	THREE_OF_CLUBS,
	FOUR_OF_CLUBS,
	FIVE_OF_CLUBS,
	SIX_OF_CLUBS,
	SEVEN_OF_CLUBS,
	EIGHT_OF_CLUBS,
	NINE_OF_CLUBS,
	TEN_OF_CLUBS,
	JACK_OF_CLUBS,
	QUEEN_OF_CLUBS,
	KING_OF_CLUBS,
	ACE_OF_CLUBS,
	TWO_OF_DIAMONDS,
	THREE_OF_DIAMONDS,
	FOUR_OF_DIAMONDS,
	FIVE_OF_DIAMONDS,
	SIX_OF_DIAMONDS,
	SEVEN_OF_DIAMONDS,
	EIGHT_OF_DIAMONDS,
	NINE_OF_DIAMONDS,
	TEN_OF_DIAMONDS,
	JACK_OF_DIAMONDS,
	QUEEN_OF_DIAMONDS,
	KING_OF_DIAMONDS,
	ACE_OF_DIAMONDS,
	BACK_OF_CARD
}

signal player_joined(username, isHost)
signal player_left(username)

export var port: int = 45555
export var max_clients: int = 6

onready var _connection_timer: Timer = $ConnectionTimer

var _peer: NetworkedMultiplayerENet
var _username: String = "" setget set_username, get_username
var _ip_address: String = "" setget , get_ip_address
var players: Dictionary = {}

var _deck: Array = []


func _ready():
	for value in CardValues.values():
		_deck.append(value)

	_deck.shuffle()

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


func get_next_card() -> String:
	return _deck.pop_front()


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
	get_tree().change_scene("res://Scenes/LobbyMenu.tscn")


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
