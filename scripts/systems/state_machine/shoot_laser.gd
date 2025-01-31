class_name ShootLaser
extends State

signal attack_stopped

@onready var main: Node = get_tree().get_root().get_node("main")
@export var enemy: CharacterBody2D
@export var projectile: PackedScene = load("res://scenes/projectile.tscn")
@export var lasers: Array[Node2D]

var player: CharacterBody2D
var timer: float = 3

func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy.velocity = Vector2(0.0, 0.0)
	lasers[0].rotation = deg_to_rad(-90)
	lasers[1].rotation = deg_to_rad(90)

func update(delta: float) -> void:
	if(timer > 0):
		for i in lasers:
			i.color = Color.YELLOW
			i.enable()
		lasers[0].rotation += deg_to_rad((get_process_delta_time() * 90) / 4)
		lasers[1].rotation -= deg_to_rad((get_process_delta_time() * 90) / 4)
		timer -= delta
	elif(timer > -1):
		stop_attack()
		timer = -2

func stop_attack():
	for i in lasers:
		i.disable()
	lasers[0].rotation = deg_to_rad(-90)
	lasers[1].rotation = deg_to_rad(90)
	transitioned.emit(self, "Following")
	attack_stopped.emit()

func _on_yellow_triangle_cooldown_complete() -> void:
	timer = 3
