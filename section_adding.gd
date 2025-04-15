extends VBoxContainer

var section_adder_scene: PackedScene = preload("res://section_adder.tscn")


func column_adding_enable() -> void:
	add_theme_constant_override(&"separation", 4)
	for i in get_child_count(false) + 1:
		var section_adder: Control = section_adder_scene.instantiate()
		add_child(section_adder)
		move_child(section_adder, i + i)
		section_adder.set_meta(&"section_adder", true)


func column_adding_disable() -> void:
	add_theme_constant_override(&"separation", 8)
	for child in get_children(false):
		if child.has_meta(&"section_adder"):
			child.queue_free()
