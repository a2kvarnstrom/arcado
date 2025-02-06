extends Control

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


func _on_doble_project_gun_pressed() -> void:
	player.weapon.set_weapon(Globals.WEAPONS.DOUBLE)


func _on_heave_ball_gun_pressed() -> void:
	player.weapon.set_weapon(Globals.WEAPONS.HEAVY)


func _on_expanding_circel_gun_pressed() -> void:
	player.weapon.set_weapon(Globals.WEAPONS.GROWING)


func _on_button_pressed() -> void:
	get_node("../VBoxContainer").visible = true
	queue_free()
