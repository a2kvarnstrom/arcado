extends Control

func _on_button_pressed() -> void:
	get_node("../").menu.visible = true
	queue_free()


func _on_button_2_pressed() -> void:
	FlowerwallPp.queue_free()
	$VBoxContainer/Button2.queue_free()
	get_node("../").add_world_env_node = false
