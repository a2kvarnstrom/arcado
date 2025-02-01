extends Node2D

var color: Color

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, 0.0), Vector2(-20.0, -10.0), Vector2(-20.0, 10.0)]), PackedColorArray([color]))
	draw_circle(Vector2(-20.0, 0.0), 10.0, color)
