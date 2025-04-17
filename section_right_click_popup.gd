extends PopupMenu

signal add_card
signal add_section(side: Side)
signal remove_section

enum MenuItemId {
	ADD_CARD,
	REMOVE_SECTION
}


func _ready() -> void:
	add_icon_item(preload("res://icons/add.svg"), "Add card", MenuItemId.ADD_CARD)
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
	add_submenu_node_item("Add section", add_section_submenu)
	set_item_icon(2, preload("res://icons/add_section.svg"))

	add_icon_item(preload("res://icons/remove_section.svg"), "Remove section", MenuItemId.REMOVE_SECTION)


func _id_pressed(id: int) -> void:
	match id:
		MenuItemId.ADD_CARD:
			add_card.emit()
		MenuItemId.REMOVE_SECTION:
			remove_section.emit()
