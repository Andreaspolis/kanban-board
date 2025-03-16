extends VBoxContainer

var card_scene: PackedScene = preload("res://card.tscn")


func _add_card_pressed() -> void:
	var card = card_scene.instantiate()
	add_child(card)
