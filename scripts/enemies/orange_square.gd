extends CharacterBody2D

@export var SPEED: float = 100.0
@export var stop_dist: float = 400.0

@onready var main: Node = get_tree().get_root().get_node("main")

var projectile: PackedScene = preload("res://scenes/projectile.tscn")
var player: CharacterBody2D
var cooldown: float = 1


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	var direction: Vector2 = player.global_position - global_position
	if(direction.length() > stop_dist):
		global_position = global_position.move_toward(player.global_position, SPEED * delta)
	
	var angle_to_player: float = global_position.direction_to(player.global_position).angle() + deg_to_rad(90)
	rotation = angle_to_player

func _process(delta: float) -> void:
	if(cooldown <= 0):
		shoot()
		cooldown = 1.0
	else:
		cooldown -= delta

func _draw() -> void:
	draw_rect(Rect2(-27.5, -27.5, 55.0, 55.0), Color.ORANGE, true, -1.0, true)

func _on_health_health_depleted() -> void:
	queue_free()

func shoot() -> void:
	for direction in [-1, 0, 1, 2]:
		var instance: Node = projectile.instantiate()
		direction *= 90
		instance.dir = global_rotation + deg_to_rad(direction)
		instance.spawn_pos = global_position
		instance.spawn_rot = global_rotation + deg_to_rad(direction+90)
		instance.zdex = z_index - 1
		main.add_child.call_deferred(instance)
