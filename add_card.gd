extends VBoxContainer


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("Can drop ", data, " at ", at_position)
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("Dropped ", data, " at ", at_position)
	data.reparent(self)


func _add_card_pressed() -> void:
	var card = preload("res://card.tscn").instantiate()
	add_child(card)
