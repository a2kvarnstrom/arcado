extends CharacterBody2D

@export var SPEED = 50.0

@onready var effect_range: Area2D = $EffectRange

var enemy_affected: CharacterBody2D
var closest_dist: float

func _ready() -> void:
	closest_dist = 50000000.0

func _draw() -> void:
	draw_polygon(PackedVector2Array([Vector2(50.0, 0.0)+Vector2(-75.0, -43.301), Vector2(100.0, 0.0)+Vector2(-75.0, -43.301), Vector2(125.0, 43.301)+Vector2(-75.0, -43.301), Vector2(100.0, 86.603)+Vector2(-75.0, -43.301), Vector2(50.0, 86.603)+Vector2(-75.0, -43.301), Vector2(25.0, 43.301)+Vector2(-75.0, -43.301)]), PackedColorArray([Color.PURPLE]))
	draw_circle(Vector2(0, 0), 225, Color.PURPLE, false)

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if(enemy_affected):
		var direction: Vector2 = enemy_affected.global_position - global_position
		if(direction.length() > 225):
			global_position = global_position.move_toward(enemy_affected.global_position, SPEED * delta)
			closest_dist = 50000000.0
	else:
		closest_dist = 50000000.0
		var enemies := get_tree().current_scene.get_node("./StateMachine/EnemyWave").get_children()
		var enemy_to_follow: CharacterBody2D
		for enemy in enemies:
			var dist = global_position.distance_squared_to(enemy.global_position)
			if(dist < closest_dist && enemy != self && !enemy.has_node("EffectRange") && enemy.get_node("./Hurtbox").damage_reduction != 100):
				closest_dist = dist
				enemy_to_follow = enemy
		if(enemy_to_follow):
			global_position = global_position.move_toward(enemy_to_follow.global_position, SPEED * delta)

func _on_effect_range_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if(!enemy_affected && !body.has_node("EffectRange")):
		if(!body.has_method("pause") && body.has_node("Health") && body.get_node("./Hurtbox").damage_reduction != 100):
			print_debug("body enter :D")
			enemy_affected = body
			enemy_affected.get_node("./Hurtbox").damage_reduction = 100

func _on_effect_range_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if(body == enemy_affected && enemy_affected):
		print_debug("body exit D:")
		enemy_affected.get_node("./Hurtbox").damage_reduction = 0.0
		enemy_affected = null

func _on_health_health_depleted() -> void:
	queue_free()
