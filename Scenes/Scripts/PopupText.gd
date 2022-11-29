extends Label
class_name PopupText

const TWEEN_DURATION = 0.8

onready var _tween = $Tween
onready var _timer = $Timer


func set_ttl(time: int) -> void:
	_timer.wait_time = time


func display_text(text: String):
	self.text = text
	_tween.interpolate_property(self, "percent_visible", 0, 1, TWEEN_DURATION)
	_timer.start()
	_tween.start()


func _on_Timer_timeout():
	percent_visible = 0
