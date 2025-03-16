extends TextEdit

@export var check_button: BaseButton
@export var edit_button: BaseButton


func _check_button_pressed() -> void:
	editable = false
	focus_mode = Control.FOCUS_NONE
	mouse_default_cursor_shape = Control.CURSOR_DRAG
	check_button.visible = false
	edit_button.visible = true


func _edit_button_pressed() -> void:
	editable = true
	focus_mode = Control.FOCUS_ALL
	mouse_default_cursor_shape = Control.CURSOR_IBEAM
	check_button.visible = true
	edit_button.visible = false
