extends CanvasLayer
class_name MainMenu

onready var _username_input: ShakingInput = $UsernameInput


func _ready():
	_username_input.text = NetworkManager.get_username()


func _on_HostButton_pressed() -> void:
	if _username_input.text == "":
		_username_input.shake()
	else:
		NetworkManager.create_server()
		NetworkManager.set_username(_username_input.text)
		get_tree().change_scene("res://Scenes/HostMenu.tscn")


func _on_JoinButton_pressed() -> void:
	if _username_input.text == "":
		_username_input.shake()
	else:
		NetworkManager.set_username(_username_input.text)
		get_tree().change_scene("res://Scenes/JoinMenu.tscn")
