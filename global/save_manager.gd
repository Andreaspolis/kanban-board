extends Node

var data: Array = [[placeholder_section()]]


func _ready() -> void:
	var save_file := FileAccess.open("user://savefile.save", FileAccess.READ)
	data = save_file.get_var()
	print("Load: ", data)


func column_added(index: int) -> void:
	data.insert(index, [placeholder_section()])


func column_removed(index: int) -> void:
	data.remove_at(index)


func section_added(column_index: int, section_index: int) -> void:
	data[column_index].insert(section_index, placeholder_section())


func section_removed(column_index: int, section_index: int) -> void:
	data[column_index].remove_at(section_index)


func section_renamed(column_index: int, section_index: int, text: String) -> void:
	data[column_index][section_index].title = text


func card_added(column_index: int, section_index: int) -> void:
	data[column_index][section_index].cards.append("")


func card_removed(column_index: int, section_index: int, card_index: int) -> void:
	data[column_index][section_index].cards.remove_at(card_index)


func card_moved(
	column_from: int, section_from: int, card_from: int,
	column_to: int, section_to: int
) -> void:
	var card = data[column_from][section_from].cards.pop_at(card_from)
	data[column_to][section_to].cards.append(card)


func card_edited(
	column_index: int, section_index: int, card_index: int,
	text: String
) -> void:
	data[column_index][section_index].cards[card_index] = text


func placeholder_section() -> Dictionary:
	return {
		"title": "",
		"cards": []
	}


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
		get_tree().quit()


func save_data() -> void:
	var save_file := FileAccess.open("user://savefile.save", FileAccess.WRITE)
	save_file.store_var(data)
	print("Save: ", data)
