extends CharacterBody2D

@export var SPEED: float = 100.0
@export var stop_dist: float = 400.0
@onready var laser: Node2D = $Laser
@onready var off_screen_marker: Node2D = $OffScreenMarker

var cooldown: float
var player: CharacterBody2D

signal cooldown_complete

func _ready() -> void:
	off_screen_marker.color = Color.YELLOW
	player = get_tree().get_first_node_in_group("Player")
	print("triangle")

func _on_health_health_depleted() -> void:
	queue_free()

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(0.0, -70), Vector2(70, 70), Vector2(-70, 70)]), PackedColorArray([Color.YELLOW]))

func _process(delta: float) -> void:
	if(cooldown > 0):
		cooldown -= delta
	elif(cooldown > -1):
		cooldown_complete.emit()
		cooldown = -2

func _on_shooting_attack_stopped() -> void:
	cooldown = 12.0
