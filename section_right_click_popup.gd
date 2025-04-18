extends PopupMenu

signal add_card
signal add_section(side: Side)
signal remove_section

enum MenuItemId {
	ADD_CARD,
	REMOVE_CARD,
	ADD_SECTION,
	REMOVE_SECTION
}

var removable_card: Control = null


func _ready() -> void:
	add_icon_item(
		preload("res://icons/add.svg"),
		"Add card", MenuItemId.ADD_CARD
	)
	add_icon_item(
		preload("res://icons/remove.svg"),
		"Remove card", MenuItemId.REMOVE_CARD
	)
	add_separator()

	var add_section_submenu := PopupMenu.new()
	add_section_submenu.add_icon_item(
		preload("res://icons/add_section_left.svg"),
		"Left", SIDE_LEFT
	)
	add_section_submenu.add_icon_item(
		preload("res://icons/add_section_top.svg"),
		"Top", SIDE_TOP
	)
	add_section_submenu.add_icon_item(
		preload("res://icons/add_section_right.svg"),
		"Right", SIDE_RIGHT
	)
	add_section_submenu.add_icon_item(
		preload("res://icons/add_section_bottom.svg"),
		"Bottom", SIDE_BOTTOM
	)
	add_section_submenu.id_pressed.connect(
		func(id: int):
			add_section.emit(id)
	)
	add_submenu_node_item(
		"Add section", add_section_submenu, MenuItemId.ADD_SECTION
	)
	set_item_icon(
		get_item_index(MenuItemId.ADD_SECTION),
		preload("res://icons/add_section.svg")
	)

	add_icon_item(
		preload("res://icons/remove_section.svg"),
		"Remove section", MenuItemId.REMOVE_SECTION
	)


func _about_to_popup() -> void:
	set_item_disabled(get_item_index(MenuItemId.REMOVE_CARD),
		removable_card == null
	)
	set_item_disabled(get_item_index(MenuItemId.REMOVE_SECTION),
		get_parent().get_parent().get_child_count() == 1
		and get_parent().get_parent().get_parent().get_child_count() == 1
	)


func _id_pressed(id: int) -> void:
	match id:
		MenuItemId.ADD_CARD:
			add_card.emit()
		MenuItemId.REMOVE_CARD:
			SaveManager.card_removed(
				get_parent().get_parent().get_index(),
				get_parent().get_index(),
				removable_card.get_index()
			)
			removable_card.queue_free()
		MenuItemId.REMOVE_SECTION:
			remove_section.emit()
