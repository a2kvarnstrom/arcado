extends Control

func _on_button_pressed() -> void:
	get_node("../VBoxContainer").visible = true
	queue_free()
