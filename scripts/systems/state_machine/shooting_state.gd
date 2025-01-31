class_name ShootingState
extends State

@onready var main: Node = get_tree().get_root().get_node("main")
@export var enemy: CharacterBody2D
@export var projectile: PackedScene = load("res://scenes/projectile.tscn")

var player: CharacterBody2D
var cooldown: float = 1

func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy.velocity = Vector2(0.0, 0.0)

func physics_update(_delta: float) -> void:
	var direction: Vector2 = player.global_position - enemy.global_position
	if(direction.length() > 400):
		transitioned.emit(self, "Following")
	
	var angle_to_player: float = enemy.global_position.direction_to(player.global_position).angle()
	enemy.rotation = move_toward(enemy.rotation, angle_to_player, 1)

func update(delta: float) -> void:
	if(cooldown <= 0):
		shoot()
		cooldown = 1.0
	else:
		cooldown -= delta

func shoot() -> void:
	var instance: Node = projectile.instantiate()
	instance.dir = enemy.rotation + deg_to_rad(90)
	instance.spawn_pos = enemy.global_position
	instance.spawn_rot = enemy.rotation
	instance.zdex = enemy.z_index - 1
	main.add_child.call_deferred(instance)
