extends Node2D

onready var _ip_input: ShakingInput = $CanvasLayer/IpInput


func _on_GoBackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_JoinButton_pressed():
	if _ip_input.text == "":
		_ip_input.shake()
	else:
		pass
