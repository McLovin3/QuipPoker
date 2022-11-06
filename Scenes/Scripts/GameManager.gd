extends Node2D

var _username: String = "" setget set_username, get_username


func set_username(username: String) -> void:
	_username = username


func get_username() -> String:
	return _username
