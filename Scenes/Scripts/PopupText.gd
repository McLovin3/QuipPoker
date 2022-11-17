extends Label
class_name PopupText

onready var _tween = $Tween
onready var _timer = $Timer


func display_text(text):
	_timer.start()
	_tween.interpolate_property(self, percent_visible, 0, 1, _timer.wait_time - 1)
	_tween.start()
	text = text


func _on_Timer_timeout():
	percent_visible = 0
