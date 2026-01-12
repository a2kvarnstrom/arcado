class_name Zap
extends CharacterBody2D

@onready var main: Node = get_tree().get_root().get_node("main")
@onready var hitbox: Hitbox = $Hitbox

var damage: float
var zap_scene: PackedScene = preload("res://scenes/zap.tscn")

var stacks: int

var duration_timer: Timer = null
@export var duration: float = 1.0

func _draw() -> void:
	draw_string(load("res://fonts/RETROTECH.ttf"), Vector2.ZERO, "skåle")

func _ready() -> void:
	if(stacks == 0):
		return
	get_node("Hitbox").set_damage(damage)
	var enemies := get_tree().current_scene.get_node("./StateMachine/EnemyWave").get_children()
	var distances: Array[Array]
	for i in enemies:
		if(!i.get_node("Hurtbox").effects.has(Globals.EFFECTS.ZAP)):
			distances.append([i, global_position.distance_squared_to(i.global_position)])
	distances.sort_custom(sort_ascending)
	if(distances.size() > 1):
		var enemy_to_zap: CharacterBody2D = distances[1][0]
		var zap: Zap = zap_scene.instantiate()
		zap.stacks = stacks - 1
		zap.damage = damage
		zap.global_position = enemy_to_zap.global_position
		main.add_child.call_deferred(zap)
	duration_timer = Timer.new()
	duration_timer.one_shot = true
	add_child(duration_timer)
	duration_timer.timeout.connect(self_destruct)
	duration_timer.set_wait_time(duration)
	duration_timer.start()

func self_destruct() -> void:
	queue_free()

func sort_ascending(a, b):
	if(a[1] < b[1]):
		return true
	return false
