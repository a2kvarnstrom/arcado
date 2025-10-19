class_name Explosion
extends CharacterBody2D

@export var duration: float = 1.0

var duration_timer: Timer = null

var damage: float = 5.0

func _draw() -> void:
	draw_circle(Vector2.ZERO, 300, Color.DIM_GRAY, false, 10.0, true)

func _ready() -> void:
	get_node("Hitbox").set_damage(damage)
	duration_timer = Timer.new()
	duration_timer.one_shot = true
	add_child(duration_timer)
	duration_timer.timeout.connect(self_destruct)
	duration_timer.set_wait_time(duration)
	duration_timer.start()

func self_destruct() -> void:
	queue_free()
