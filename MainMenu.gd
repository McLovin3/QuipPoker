extends Node2D

export var tween_duration: float = 0.05
export var nb_shakes: int = 5
export var shake_distance: float = 5

onready var _username_input: LineEdit = $CanvasLayer/UsernameInput
onready var _username_input_tween: Tween = $CanvasLayer/UsernameInput/Tween

var _shake_count: int


func _shake_username_input() -> void:
	if _shake_count > 0:
		var side = 1 if _shake_count % 2 == 0 else -1

		if _shake_count == 1 or _shake_count == nb_shakes:
			_username_input_tween.interpolate_property(
				_username_input,
				"rect_position:x",
				_username_input.rect_position.x,
				_username_input.rect_position.x + (shake_distance * side),
				tween_duration
			)

		else:
			_username_input_tween.interpolate_property(
				_username_input,
				"rect_position:x",
				_username_input.rect_position.x,
				_username_input.rect_position.x + (shake_distance * 2 * side),
				tween_duration
			)

		_username_input_tween.start()
		_shake_count -= 1


func _on_HostButton_pressed() -> void:
	if _username_input.text == "" and _shake_count == 0:
		_shake_count = nb_shakes
		_shake_username_input()
	else:
		pass


func _on_JoinButton_pressed() -> void:
	if _username_input.text == "" and _shake_count == 0:
		_shake_count = nb_shakes
		_shake_username_input()
	else:
		pass


func _on_Tween_tween_all_completed() -> void:
	_shake_username_input()
