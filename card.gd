extends TextEdit

signal open_popup(location: Vector2, card: Control)


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview := Control.new()
	var preview_item: Control = self.duplicate(0)
	preview.add_child(preview_item)
	preview_item.size = self.size
	preview_item.position = -at_position
	set_drag_preview(preview)
	return self


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			open_popup.emit(event.global_position, self)
