extends CharacterBody2D


@export var SPEED = 50.0

func _draw() -> void:
	#draw_circle(Vector2(0.0, -7.5), 15, Color.PURPLE, true, -1.0, true)
	#draw_circle(Vector2(0.0, 7.5), 15, Color.PURPLE, true, -1.0, true)
	draw_rect(Rect2(-15.0, -15.0, 22.5, 30), Color.PURPLE, true, -1.0, true)

func _physics_process(delta: float) -> void:
	pass
