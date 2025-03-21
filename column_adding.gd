extends HBoxContainer

var column_adder_scene: PackedScene = preload("res://column_adder.tscn")


func _column_adding_enable() -> void:
	add_theme_constant_override(&"separation", 4)
	for i in get_child_count(false) + 1:
		var column_adder: Control = column_adder_scene.instantiate()
		add_child(column_adder)
		move_child(column_adder, i + i)
		column_adder.set_meta(&"column_adder", true)


func _column_adding_disable() -> void:
	add_theme_constant_override(&"separation", 8)
	for child in get_children(false):
		if child.has_meta(&"column_adder"):
			child.queue_free()
