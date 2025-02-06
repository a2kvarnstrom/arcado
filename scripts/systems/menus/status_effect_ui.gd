extends Control

@export var player: Player   

func _on_toxin_pressed() -> void:
	pass 

func _on_cold_pressed() -> void:
	pass # Replace with function body.

func _on_zap_pressed() -> void:
	pass # Replace with function body.

func _on_explodi_pressed() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	get_node("../VBoxContainer").visible = true
	queue_free()
