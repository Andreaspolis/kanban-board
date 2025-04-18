extends VBoxContainer


func load_data() -> void:
	for section: Dictionary in SaveManager.data[get_index()]:
		var section_node = preload("res://section.tscn").instantiate()
		section_node.title_line.text = section.title
		add_child(section_node)
		section_node.load_data()
