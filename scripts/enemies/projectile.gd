extends Bullet

@onready var pierce: Pierce = $Pierce

func process(delta: float) -> void:
	lifespan -= delta
	if(lifespan < 0):
		disable()
	if(growing):
		scale += Vector2(delta, delta)

func physics_process(delta: float) -> void:
	velocity = Vector2(0,-speed).rotated(direction.angle()) * (delta * 60)
	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(-16, -6, 32, 12), Color.WHITE, true, -1.0, true)

func _on_pierce_pierce_depleted() -> void:
	disable()
