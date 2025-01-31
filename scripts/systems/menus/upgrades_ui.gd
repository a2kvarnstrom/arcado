extends Control

@export var player: Player 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dmg_pressed() -> void:
	player.dmg += 3


func _on_hp_pressed() -> void:
	player.health.set_max_health(player.health.get_max_health() + 5)


func _on_def_pressed() -> void:
	pass # Replace with function body.


func _on_atkspeed_pressed() -> void:
	player.atk_speed += 0.1


func _on_mvmntspeed_pressed() -> void:
	player.SPEED += 15


func _on_stsdur_pressed() -> void:
	pass # Replace with function body.


func _on_stsdmg_pressed() -> void:
	pass # Replace with function body.


func _on_weapons_pressed() -> void:
	add_child(load("res://scenes/weapon_ui.tscn").instantiate())
	$VBoxContainer.visible = false
