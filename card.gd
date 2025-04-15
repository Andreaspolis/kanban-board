extends TextEdit

@export var check_button: BaseButton
@export var edit_button: BaseButton


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview := Control.new()
	var preview_item: Control = self.duplicate(0)
	preview.add_child(preview_item)
	preview_item.size = self.size
	preview_item.position = -at_position
	set_drag_preview(preview)
	return self


func _check_button_pressed() -> void:
	editable = false
	focus_mode = FOCUS_NONE
	mouse_default_cursor_shape = CURSOR_DRAG
	check_button.visible = false
	edit_button.visible = true


func _edit_button_pressed() -> void:
	editable = true
	focus_mode = FOCUS_ALL
	mouse_default_cursor_shape = CURSOR_IBEAM
	check_button.visible = true
	edit_button.visible = false
