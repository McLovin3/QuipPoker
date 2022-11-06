extends CanvasLayer


func _on_ExitButton_pressed():
	get_tree().network_peer = null
	get_tree().change_scene("res://Scenes/JoinMenu.tscn")
