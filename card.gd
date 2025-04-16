extends TextEdit


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview := Control.new()
	var preview_item: Control = self.duplicate(0)
	preview.add_child(preview_item)
	preview_item.size = self.size
	preview_item.position = -at_position
	set_drag_preview(preview)
	return self
