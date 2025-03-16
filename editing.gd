extends TextureButton

@export var submit_button: BaseButton


func _pressed() -> void:
	self.visible = false
	submit_button.visible = true


func _submit_pressed() -> void:
	self.visible = true
	submit_button.visible = false
