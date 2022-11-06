extends CanvasLayer
class_name JoinMenu

onready var _ip_input: ShakingInput = $IpInput
onready var _join_button: Button = $JoinButton


func _ready():
	get_tree().connect("connection_failed", self, "_connection_failed")


func _on_GoBackButton_pressed():
	GameManager.close_client()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_JoinButton_pressed():
	if _ip_input.text.is_valid_ip_address():
		_ip_input.editable = false
		_join_button.disabled = true
		GameManager.join_server(_ip_input.text)
	else:
		_ip_input.shake()


func _connection_failed():
	_ip_input.editable = true
	_join_button.disabled = false
	_ip_input.shake()
