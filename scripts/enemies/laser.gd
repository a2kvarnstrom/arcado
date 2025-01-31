extends Node2D

@export var color: Color = Color.GREEN

@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D

func _ready() -> void:
	disable()

func _draw():
	draw_line(Vector2(0.0, 0.0), Vector2(0.0, -5000.0), color, 15, true)

func enable():
	hitbox.disabled = false
	visible = true

func disable():
	hitbox.disabled = true
	visible = false
