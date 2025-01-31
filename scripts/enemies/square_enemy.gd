extends CharacterBody2D

func _ready() -> void:
	print("square")

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-27.5, -27.5, 55.0, 55.0), Color.RED, true, -1.0, true)

func _on_health_health_depleted() -> void:
	queue_free()
