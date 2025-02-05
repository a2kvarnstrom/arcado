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
	print("triangle")

func _on_health_health_depleted() -> void:
	queue_free()

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, -55), Vector2(55, 55), Vector2(-55, 55)]), PackedColorArray([Color.GREEN]))
	draw_dashed_line(Vector2(0.0, 0.0), Vector2(0.0, -5000.0), Color.GREEN, 2.5, 15.0, true, true)

func _process(delta: float) -> void:
	if((Input.is_action_pressed("up") || Input.is_action_pressed("down") || Input.is_action_pressed("left") || Input.is_action_pressed("right")) && cooldown <= 0):
		# shoot only if player move
		laser.enable()
	else:
		laser.disable()
	
	if(cooldown > 0):
		cooldown -= delta
	
	# spin
	rotation += deg_to_rad(90 * delta)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = player.global_position - global_position
	if(direction.length() > stop_dist):
		position = position.move_toward(player.global_position, SPEED * delta)
