extends Node2D

var color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, 0.0), Vector2(-20.0, -10.0), Vector2(-20.0, 10.0)]), PackedColorArray([color]))
	draw_circle(Vector2(-20.0, 0.0), 10.0, color)
