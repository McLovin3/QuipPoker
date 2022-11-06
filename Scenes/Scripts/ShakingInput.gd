extends LineEdit
class_name ShakingInput

export var tween_duration: float = 0.05
export var nb_shakes: int = 5
export var shake_distance: float = 5

onready var _tween: Tween = $Tween

var _shake_count: int
var _shaking: bool = false


func shake() -> void:
	if not _shaking:
		_shake_count = nb_shakes
		_shaking = true
		_move_tween()


func _move_tween() -> void:
	if _shake_count > 0:
		var side = 1 if _shake_count % 2 == 0 else -1

		if _shake_count == 1 or _shake_count == nb_shakes:
			_tween.interpolate_property(
				self,
				"rect_position:x",
				self.rect_position.x,
				self.rect_position.x + (shake_distance * side),
				tween_duration
			)

		else:
			_tween.interpolate_property(
				self,
				"rect_position:x",
				self.rect_position.x,
				self.rect_position.x + (shake_distance * 2 * side),
				tween_duration
			)

		_tween.start()
		_shake_count -= 1

	else:
		_shaking = false


func _on_Tween_tween_all_completed() -> void:
	_move_tween()
