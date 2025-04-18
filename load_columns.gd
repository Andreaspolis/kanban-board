extends HBoxContainer


func _ready() -> void:
	for column: Array in SaveManager.data:
		var column_node = preload("res://column.tscn").instantiate()
		add_child(column_node)
		column_node.load_data()
