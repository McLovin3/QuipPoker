extends CanvasLayer
class_name HostingMenu


func _on_GoBackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
