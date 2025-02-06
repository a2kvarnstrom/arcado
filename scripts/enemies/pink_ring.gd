extends CharacterBody2D

@onready var main: Node = get_tree().get_root().get_node("main")
@onready var projectile = load("res://scenes/circle_projectile.tscn")
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var off_screen_marker: Node2D = $OffScreenMarker

var shoot_cooldown: float = 1.0
var player: CharacterBody2D 

func _ready() -> void:
	off_screen_marker.color = Color.HOT_PINK
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if(shoot_cooldown > 0):
		shoot_cooldown -= delta
	
	if(shoot_cooldown < 0):
		shoot()

func shoot() -> void:
	shoot_cooldown = 2.5
	var instance: Node = projectile.instantiate()
	instance.dir = rotation + deg_to_rad(90)
	instance.spawn_pos = global_position
	instance.spawn_rot = rotation
	instance.zdex = z_index - 1
	instance.color = Color.HOT_PINK
	instance.lifespan = 10.0
	main.add_child.call_deferred(instance)

func _draw() -> void:
	draw_circle(Vector2(0.0, 0.0), 35, Color.HOT_PINK, false, 10.0, true)

func _on_health_health_depleted() -> void:
	queue_free()
