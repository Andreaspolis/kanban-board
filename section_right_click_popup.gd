extends PopupMenu

signal add_card
signal add_section(side: Side)
signal remove_section


func _ready() -> void:
	add_item("Add card", 0)
	add_separator()
	var submenu := PopupMenu.new()
	submenu.add_item("To left", 2)
	submenu.add_item("To top", 3)
	submenu.add_item("To right", 4)
	submenu.add_item("To bottom", 5)
	submenu.id_pressed.connect(_id_pressed)
	add_submenu_node_item("Add section", submenu)
	add_item("Remove section", 1)


func _id_pressed(id: int) -> void:
	match id:
		0:
			add_card.emit()
		1:
			remove_section.emit()
		2:
			add_section.emit(SIDE_LEFT)
		3:
			add_section.emit(SIDE_TOP)
		4:
			add_section.emit(SIDE_RIGHT)
		5:
			add_section.emit(SIDE_BOTTOM)
