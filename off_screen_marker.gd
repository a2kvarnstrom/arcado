extends Node2D

@onready var sprite: Node2D = $Sprite

var target_position = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	
	set_marker_position(Rect2(top_left, size))
	set_marker_rotation()

func set_marker_position(bounds: Rect2) -> void:
	sprite.global_position.x = clampi(global_position.x, bounds.position.x, bounds.end.x)
	sprite.global_position.y = clampi(global_position.y, bounds.position.y, bounds.end.y)
	
	if(bounds.has_point(global_position)):
		hide()
	else:
		show()
	

func set_marker_rotation() -> void:
	var angle: float = (global_position - sprite.global_position).angle()
	sprite.global_rotation = angle
