extends CharacterBody2D

@export var lasers: Array[Node2D]
@export var SPEED: float = 100.0
@export var stop_dist: float = 400.0

@onready var laser: Node2D = $Laser
@onready var off_screen_marker: Node2D = $OffScreenMarker
@onready var main: Node = get_tree().get_root().get_node("main")

var cooldown: float
var player: CharacterBody2D
var timer: float = 3
var attacking: bool = false

func _ready() -> void:
	off_screen_marker.color = Color.YELLOW
	player = get_tree().get_first_node_in_group("Player")
	velocity = Vector2(0.0, 0.0)
	lasers[0].rotation = deg_to_rad(-90)
	lasers[1].rotation = deg_to_rad(90)
	print("triangle")

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, -70), Vector2(70, 70), Vector2(-70, 70)]), PackedColorArray([Color.YELLOW]))

func _on_health_health_depleted() -> void:
	queue_free()

func _process(delta: float) -> void:
	if(cooldown > 0):
		cooldown -= delta
	else:
		cooldown = 15.0
		timer = 3
	
	if(timer > 0):
		attacking = true
		for i in lasers:
			i.color = Color.YELLOW
			i.enable()
		lasers[0].rotation += deg_to_rad((get_process_delta_time() * 90) / 4)
		lasers[1].rotation -= deg_to_rad((get_process_delta_time() * 90) / 4)
		timer -= delta
	elif(timer > -1):
		stop_attack()
		timer = -2

func _physics_process(delta: float) -> void:
	if(!attacking):
		var direction: Vector2 = player.global_position - global_position
		if(direction.length() > 400):
			global_position = global_position.move_toward(player.global_position, SPEED * delta)
		
		var angle_to_player: float = global_position.direction_to(player.global_position).angle() + deg_to_rad(90)
		rotation = angle_to_player

func stop_attack():
	for i in lasers:
		i.disable()
	lasers[0].rotation = deg_to_rad(-90)
	lasers[1].rotation = deg_to_rad(90)
	attacking = false
