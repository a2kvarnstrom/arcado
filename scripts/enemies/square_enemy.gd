extends CharacterBody2D
@onready var off_screen_marker: Node2D = $OffScreenMarker

@export var SPEED: float = 100

var cooldown: float = 1.0

func _ready() -> void:
	off_screen_marker.color = Color.RED

func _physics_process(_delta: float) -> void:
	#velocity = Vector2.ZERO
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-27.5, -27.5, 55.0, 55.0), Color.RED, true, -1.0, true)

func _on_health_health_depleted() -> void:
	queue_free()
