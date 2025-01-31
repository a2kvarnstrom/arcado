extends CharacterBody2D
@onready var off_screen_marker: Node2D = $OffScreenMarker

func _ready() -> void:
	off_screen_marker.color = Color.RED
	print("square")

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-27.5, -27.5, 55.0, 55.0), Color.RED, true, -1.0, true)

func _on_health_health_depleted() -> void:
	queue_free()
