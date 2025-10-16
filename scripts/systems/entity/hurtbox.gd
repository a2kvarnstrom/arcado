class_name Hurtbox
extends Area2D

signal received_damage(damage: float)

@onready var main: Node = get_tree().get_root().get_node("main")
@onready var hitbox: Hitbox
@export var enemy: CharacterBody2D
@export var health: Health
@export var pierce: int = 1
@export var damage_reduction: float = 0.0

var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
var can_take_damage: bool = true
var effects: Array[Globals.EFFECTS]

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit_box: Area2D) -> void:
	if(hit_box != null && can_take_damage):
		if(hit_box is Hitbox):
			var total_dmg: float = 0.0
			total_dmg = hit_box.damage * (100-damage_reduction)/100
			health.set_health(health.health - total_dmg)
			received_damage.emit(hit_box.damage)
			effects = hit_box.get_effects()
			apply_effect()
			if(hit_box.pierce):
				hit_box.pierce.set_pierce(hit_box.pierce.get_pierce() - pierce)

func apply_effect() -> void:
	var dot: float = 0.0
	var m_speed_modifier: float = 1.0
	var atk_speed_modifier: float = 1.0
	for i in effects:
		match(i):
			Globals.EFFECTS.TOXIN:
				dot = dot + 4.0
			Globals.EFFECTS.COLD:
				m_speed_modifier = m_speed_modifier * 0.7
				atk_speed_modifier = atk_speed_modifier * 0.7
			Globals.EFFECTS.EXPLODE:
				var explosion: Explosion = explosion_scene.instantiate()
				explosion.global_position = enemy.global_position
				explosion.duration = 1
				main.add_child.call_deferred(explosion)
	dot = 0 - dot
	atk_speed_modifier = 2 - atk_speed_modifier
	#print("atk: %f\ndot: %f\nmvmt: %f" % [atk_speed_modifier, dot, m_speed_modifier])
	health.set_regen(dot)
	enemy.SPEED = enemy.SPEED * m_speed_modifier
	enemy.cooldown = enemy.cooldown * atk_speed_modifier
