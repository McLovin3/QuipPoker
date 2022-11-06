extends CanvasLayer
class_name HostMenu


func _on_GoBackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
