extends CharacterBody2D

@export var SPEED: float = 100.0
@export var stop_dist: float = 400.0
@onready var laser: Node2D = $Laser
@onready var off_screen_marker: Node2D = $OffScreenMarker

var cooldown: float = 1.0
var player: CharacterBody2D

func _ready() -> void:
	off_screen_marker.color = Color.GREEN
	player = get_tree().get_first_node_in_group("Player")

func _on_health_health_depleted() -> void:
	queue_free()

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, -55), Vector2(55, 55), Vector2(-55, 55)]), PackedColorArray([Color.GREEN]))
	draw_dashed_line(Vector2(0.0, 0.0), Vector2(0.0, -5000.0), Color.GREEN, 2.5, 15.0, true, true)

func _process(delta: float) -> void:
	if(player.velocity != Vector2.ZERO && cooldown <= 0):
		# shoot only if player move
		laser.enable()
	else:
		laser.disable()
	
	if(cooldown > 0):
		cooldown -= delta
	
	# spin
	rotation += deg_to_rad(90 * delta)

func _physics_process(delta: float) -> void:
	position = position.move_toward(find_furthest_point(player.position, position), SPEED * delta)
	velocity = Vector2.ZERO
	move_and_slide()

func find_furthest_point(pos1: Vector2, pos2: Vector2) -> Vector2:
	var corners: Array[Vector2] = [Vector2(800, 400), Vector2(-800, 400), Vector2(-800, -400), Vector2(800, -400)]
	var x: int = sign(pos2.x - pos1.x)
	var y: int = sign(pos2.y - pos1.y)
	if(x == -1):
		if(y == -1):
			return corners[2]
		if(y == 1):
			return corners[1]
	if(x == 1):
		if(y == -1):
			return corners[3]
		if(y == 1):
			return corners[0]
	return corners[0]
