extends CharacterBody2D

@export var SPEED = 50.0
@onready var effect_range: Area2D = $EffectRange
@onready var indicator: GPUParticles2D = $Indicator
var enemy_affected: CharacterBody2D

func _draw() -> void:
	draw_circle(Vector2(0.0, -15), 30, Color.PURPLE, true, -1.0, true)
	draw_circle(Vector2(0.0, 15), 30, Color.PURPLE, true, -1.0, true)
	draw_rect(Rect2(-30.5, -20, 61, 40), Color.PURPLE, true, -1.0, true)

func _process(_delta: float) -> void:
	if(!enemy_affected):
		indicator.visible = false
	else:
		indicator.visible = true

func _on_effect_range_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	print_debug("body enter :D")
	if(!enemy_affected):
		if(!body.has_method("pause") && body.has_node("Health")):
			enemy_affected = body
			enemy_affected.get_node("./Hurtbox").damage_reduction = 100
			print(enemy_affected.get_node("./Hurtbox").damage_reduction)


func _on_effect_range_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	print_debug("body exit D:")
	if(body == enemy_affected):
		enemy_affected.get_node("./Hurtbox").damage_reduction = 0.0
		enemy_affected = null


func _on_health_health_depleted() -> void:
	queue_free()
