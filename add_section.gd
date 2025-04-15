extends TextureButton

@export var hover_panel: Panel


func _ready() -> void:
	hide_panel()


func _mouse_entered() -> void:
	hover_panel.visible = true


func _mouse_exited() -> void:
	hide_panel()


func _pressed() -> void:
	add_sibling(duplicate())
	add_sibling(load("res://section.tscn").instantiate())


func hide_panel() -> void:
	hover_panel.visible = false
