extends CharacterBody2D

@onready var main: Node = get_tree().get_root().get_node("main")
@export var move_speed: float = 50.0
@onready var projectile = load("res://scenes/circle_projectile.tscn")

var shoot_cooldown: float = 1.0
var player: CharacterBody2D 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	print("circle")

func _process(delta: float) -> void:
	if(shoot_cooldown > 0):
		shoot_cooldown -= delta
	
	if(shoot_cooldown < 0):
		shoot()

func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	position = position.move_toward(player.global_position, move_speed * delta)
	
	move_and_slide()

func shoot() -> void:
	shoot_cooldown = 5.0
	var instance: Node = projectile.instantiate()
	instance.dir = rotation + deg_to_rad(90)
	instance.spawn_pos = global_position
	instance.spawn_rot = rotation
	instance.zdex = z_index - 1
	main.add_child.call_deferred(instance)

func _draw() -> void:
	draw_circle(Vector2(0.0, 0.0), 35, Color.CORNFLOWER_BLUE, true, -1.0, true)

func _on_health_health_depleted() -> void:
	queue_free()
