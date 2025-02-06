extends Control

func _on_button_pressed() -> void:
	get_node("../").menu.visible = true
	queue_free()
