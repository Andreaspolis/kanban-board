extends Control

@export var right_click_popup: PopupMenu
@export var cards_parent: Control
@export var title_line: LineEdit


func load_data() -> void:
	for card: String in SaveManager.data[get_parent().get_index()][get_index()].cards:
		add_card_no_save(card)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			show_right_click_menu(event.global_position)


func _add_card(text: String = "") -> void:
	add_card_no_save(text)
	SaveManager.card_added(get_parent().get_index(), get_index())


func add_card_no_save(text: String = "") -> void:
	var card = preload("res://card.tscn").instantiate()
	card.text = text
	card.open_popup.connect(show_right_click_menu)
	card.text_changed.connect(_card_text_changed.bind(card))
	cards_parent.add_child(card)


func _add_section(side: Side) -> void:
	match side:
		SIDE_LEFT:
			add_column(get_parent().get_index())
		SIDE_TOP:
			add_row(get_index())
		SIDE_RIGHT:
			add_column(get_parent().get_index() + 1)
		SIDE_BOTTOM:
			add_row(get_index() + 1)


func add_column(index: int) -> void:
	var column = load("res://column.tscn").instantiate()
	column.add_child(preload("res://section.tscn").instantiate())
	get_parent().add_sibling(column)
	get_parent().get_parent().move_child(column, index)
	SaveManager.column_added(index)


func remove_column() -> void:
	SaveManager.column_removed(get_parent().get_index())
	get_parent().queue_free()


func add_row(index: int) -> void:
	var row = preload("res://section.tscn").instantiate()
	add_sibling(row)
	get_parent().move_child(row, index)
	SaveManager.section_added(get_parent().get_index(), index)


func remove_row() -> void:
	SaveManager.section_removed(get_parent().get_index(), get_index())
	queue_free()


func _remove_section() -> void:
	if get_parent().get_child_count() == 1:
		if get_parent().get_parent().get_child_count() == 1:
			push_error("Can't remove last section")
		else:
			remove_column()
	else:
		remove_row()


func _title_changed(new_text: String) -> void:
	SaveManager.section_renamed(get_parent().get_index(), get_index(), new_text)


func _can_drop_data(at_position: Vector2, _card: Variant) -> bool:
	return cards_parent.get_rect().has_point(at_position)


func _drop_data(_at_position: Vector2, card: Variant) -> void:
	var section = card.get_node("../../../../..")
	var column_index = section.get_parent().get_index()
	var section_index = section.get_index()
	var card_index = card.get_index()
	card.reparent(cards_parent)
	SaveManager.card_moved(
		column_index, section_index, card_index,
		get_parent().get_index(), get_index()
	)

func show_right_click_menu(location: Vector2, card: Control = null) -> void:
	right_click_popup.position = location
	if card:
		right_click_popup.removable_card = card
	else:
		right_click_popup.removable_card = null
	right_click_popup.popup()


func _card_text_changed(card: Control) -> void:
	SaveManager.card_edited(
		get_parent().get_index(), get_index(), card.get_index(), card.text
	)
