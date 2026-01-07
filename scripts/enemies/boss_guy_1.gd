class_name Boss1
extends CharacterBody2D

func _draw() -> void:
	draw_rect(Rect2(Vector2(-20, -280), Vector2(40, 560)), Color.DIM_GRAY)
	draw_circle(Vector2(0, -280), 20, Color.DIM_GRAY)
	draw_circle(Vector2(0, 280), 20, Color.DIM_GRAY)

func _ready() -> void:
	pass
