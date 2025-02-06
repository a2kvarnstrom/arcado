extends CharacterBody2D

@export var SPEED: float = 500
@export var dmg: float = 10
@export var lifespan: float = 3
@export var growing: bool = false

@onready var hitbox: Hitbox = $Hitbox
@onready var pierce: Pierce = $Pierce

var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready() -> void:
	hitbox.damage = dmg
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex

func _process(delta: float) -> void:
	lifespan -= delta
	if(lifespan < 0):
		queue_free()
	if(growing):
		scale += Vector2(delta, delta)

func _physics_process(delta: float) -> void:
	velocity = Vector2(0,-SPEED).rotated(dir) * (delta * 60)
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-16, -6, 32, 12), Color.WHITE, true, -1.0, true)

func _on_pierce_pierce_depleted() -> void:
	queue_free()
