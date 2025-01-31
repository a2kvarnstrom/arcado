extends CharacterBody2D

@export var SPEED: float = 300
@export var color: Color = Color.CORNFLOWER_BLUE

var lifespan: float = 10.0
var player: CharacterBody2D
var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex

func _process(delta: float) -> void:
	lifespan -= delta
	if(lifespan < 0):
		queue_free()

func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	position = position.move_toward(player.global_position, SPEED * delta)

func _draw() -> void:
	draw_circle(Vector2(0.0, 0.0), 15, color, true, -1.0, true)

func _on_pierce_pierce_depleted() -> void:
	queue_free()

func _on_health_health_depleted() -> void:
	queue_free()
