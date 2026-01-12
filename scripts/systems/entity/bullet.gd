class_name Bullet
extends CharacterBody2D

@export var speed: float = 300.0

var direction: Vector2 = Vector2.ZERO

var active: bool = false

func enter() -> void:
	pass

func enable(pos: Vector2, dir: Vector2) -> void:
	active = true
	global_position = pos
	direction = dir.normalized()
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
