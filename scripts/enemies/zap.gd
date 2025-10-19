class_name Zap
extends CharacterBody2D

@onready var main: Node = get_tree().get_root().get_node("main")
@onready var hitbox: Hitbox = $Hitbox

var damage: float
var zap_scene: PackedScene = preload("res://scenes/zap.tscn")

var stacks: int

func _ready() -> void:
	get_node("Hitbox").set_damage(damage)
	var enemies := get_tree().current_scene.get_node("./StateMachine/EnemyWave").get_children()
	var distances: Array[Array]
	for i in enemies:
		distances.append([i, global_position.distance_squared_to(i.global_position)])
	distances.sort_custom(sort_ascending)
	if(distances.size() > 1):
		var enemy_to_zap: CharacterBody2D = distances[1][0]
		if(stacks > 0):
			var zap: Zap = zap_scene.instantiate()
			zap.stacks = stacks - 1
			zap.damage = damage
			zap.global_position = enemy_to_zap.global_position
			main.add_child.call_deferred(zap)
	queue_free()

func sort_ascending(a, b):
	if(a[1] < b[1]):
		return true
	return false
