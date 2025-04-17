extends Control

@export var right_click_popup: PopupMenu
@export var cards_parent: Control


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			right_click_popup.position = event.global_position
			right_click_popup.popup()


func _add_card() -> void:
	var card = preload("res://card.tscn").instantiate()
	cards_parent.add_child(card)


func _add_section(side: int) -> void:
	match side:
		SIDE_LEFT:
			var new_column = load("res://column.tscn").instantiate()
			get_parent().add_sibling(new_column)
			get_parent().get_parent().move_child(new_column, get_parent().get_index())
		SIDE_TOP:
			var new_section = load("res://section.tscn").instantiate()
			add_sibling(new_section)
			get_parent().move_child(new_section, get_index())
		SIDE_RIGHT:
			var new_column = load("res://column.tscn").instantiate()
			get_parent().add_sibling(new_column)
			get_parent().get_parent().move_child(new_column, get_parent().get_index() + 1)
		SIDE_BOTTOM:
			var new_section = load("res://section.tscn").instantiate()
			add_sibling(new_section)
			get_parent().move_child(new_section, get_index() + 1)


func _remove_section() -> void:
	if get_parent().get_child_count() == 1:
		if get_parent().get_parent().get_child_count() == 1:
			print("Can't remove last section")
		else:
			get_parent().queue_free()
	else:
		queue_free()


func _can_drop_data(at_position: Vector2, _data: Variant) -> bool:
	return cards_parent.get_rect().has_point(at_position)


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.reparent(cards_parent)
