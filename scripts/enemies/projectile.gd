extends CharacterBody2D

@export var SPEED: float = 500

var lifespan: float = 3.0
var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready() -> void:
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex

func _process(delta: float) -> void:
	lifespan -= delta
	if(lifespan < 0):
		queue_free()

func _physics_process(delta: float) -> void:
	velocity = Vector2(0,-SPEED).rotated(dir) * (delta * 60)
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-16, -6, 32, 12), Color.WHITE, true, -1.0, true)

func _on_pierce_pierce_depleted() -> void:
	queue_free()
