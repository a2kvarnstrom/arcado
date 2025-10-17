extends CharacterBody2D

@export var SPEED: float = 300
@export var color: Color = Color.CORNFLOWER_BLUE
@export var lifespan: float = 10.0
@export var homing: bool = true
@export var can_take_damage: bool = true
@export var growing: bool = false
@export var dmg: float = 5.0

@onready var pierce: Pierce = $Pierce
@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox

var cooldown: float = 0
var player: CharacterBody2D
var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready() -> void:
	hitbox.set_damage(dmg)
	player = get_tree().get_first_node_in_group("Player")
	hurtbox.can_take_damage = can_take_damage
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
	if(homing):
		look_at(player.global_position)
		position = position.move_toward(player.global_position, SPEED * delta)
	else:
		velocity = Vector2(0,-SPEED).rotated(dir) * (delta * 60)
	move_and_slide()

func _draw() -> void:
	draw_circle(Vector2(0.0, 0.0), 15, color, true, -1.0, true)

func _on_pierce_pierce_depleted() -> void:
	queue_free()

func _on_health_health_depleted() -> void:
	queue_free()
