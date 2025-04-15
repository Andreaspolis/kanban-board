extends VBoxContainer


func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.reparent(self)


func _add_card_pressed() -> void:
	var card = preload("res://card.tscn").instantiate()
	add_child(card)
