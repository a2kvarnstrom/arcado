class_name FollowState
extends State

@export var enemy: CharacterBody2D
@export var SPEED: float = 100.0
@export var stop_dist: float = 400.0
@export var spin: bool = false
@export var rotation_offset: float = 0.0
var player: CharacterBody2D

func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")

func physics_update(delta: float) -> void:
	var direction: Vector2 = player.global_position - enemy.global_position
	if(direction.length() > stop_dist):
		enemy.global_position = enemy.global_position.move_toward(player.global_position, SPEED * delta)
	
	if(direction.length() < stop_dist):
		transitioned.emit(self, "Shooting")
	
	if(!spin):
		var angle_to_player: float = enemy.global_position.direction_to(player.global_position).angle() + deg_to_rad(rotation_offset)
		enemy.rotation = angle_to_player
	else:
		enemy.rotation += deg_to_rad(90 * delta)
