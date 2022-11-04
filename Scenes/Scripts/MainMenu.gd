extends Node2D

onready var _username_input: ShakingInput = $CanvasLayer/UsernameInput


func _on_HostButton_pressed() -> void:
	if _username_input.text == "":
		_username_input.shake()
	else:
		pass


func _on_JoinButton_pressed() -> void:
	if _username_input.text == "":
		_username_input.shake()
	else:
		get_tree().change_scene("res://Scenes/JoinMenu.tscn")
