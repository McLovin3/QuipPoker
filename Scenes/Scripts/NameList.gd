extends ItemList
class_name NameList

const _SELECTED_COLOR: Color = Color("f50078")
var _last_selected_name: int


func set_player_action_by_name(name: String, action: String) -> void:
	var index: int = _get_player_index_by_name(name)
	set_item_text(index, name + " (" + action + ")")


func set_current_player_by_name(name: String) -> void:
	var index: int = _get_player_index_by_name(name)
	set_item_custom_bg_color(_last_selected_name, Color(0, 0, 0, 0))
	set_item_custom_bg_color(index, _SELECTED_COLOR)
	_last_selected_name = index


func _get_player_index_by_name(name: String) -> int:
	for i in range(get_item_count()):
		if name in get_item_text(i):
			return i
	return -1


func set_player_names(names: Array) -> void:
	clear()
	for name in names:
		add_item(name, null, false)
	set_item_custom_bg_color(0, Color("f50078"))
	_last_selected_name = 0
