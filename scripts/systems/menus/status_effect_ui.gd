extends Control

@export var player: Player   

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _on_toxin_pressed() -> void:
	player.weapon.add_effect(Globals.EFFECTS.TOXIN) 

func _on_cold_pressed() -> void:
	player.weapon.add_effect(Globals.EFFECTS.COLD)

func _on_zap_pressed() -> void:
	player.weapon.add_effect(Globals.EFFECTS.ZAP)

func _on_explodi_pressed() -> void:
	player.weapon.add_effect(Globals.EFFECTS.EXPLODE)

func _on_button_pressed() -> void:
	get_node("../VBoxContainer").visible = true
	queue_free()
