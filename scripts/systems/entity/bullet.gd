class_name Bullet
extends CharacterBody2D

@export var hitbox: Hitbox

@export var speed: float = 300.0
@export var damage: float = 10.0
@export var lifespan: float = 2.5
@export var can_take_damage: bool = false
@export var homing: bool = false
@export var color: Color
@export var growing: bool = false

var direction: Vector2 = Vector2.ZERO

var active: bool = false

func enter() -> void:
	pass

func enable(spawn_pos: Vector2, spawn_rot: Vector2, dmg: float, zdex: int) -> void:
	hitbox.damage = dmg
	z_index = zdex
	active = true
	global_position = spawn_pos
	direction = spawn_rot.normalized()
	visible = true
	set_process(true)

func disable() -> void:
	active = false
	visible = false
	set_process(false)

func move() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
