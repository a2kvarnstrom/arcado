class_name Hurtbox
extends Area2D

signal received_damage(damage: float)

@onready var main: Node = get_tree().get_root().get_node("main")
@onready var hitbox: Hitbox
@export var enemy: CharacterBody2D
@export var health: Health
@export var pierce: int = 1
@export var damage_reduction: float = 0.0
@export var can_pierce: bool = true

var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
var zap_scene: PackedScene = preload("res://scenes/zap.tscn")
var can_take_damage: bool = true
var effects: Array[Globals.EFFECTS]

var zap_cooldown_timer: Timer = null
var zap_cooldown: float = 0.4

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	damage_reduction = 100-(100/Globals.enemy_hp_scaling)
	print("dr: ", damage_reduction)
	

func _on_area_entered(hit_box: Area2D) -> void:
	if(hit_box != null && can_take_damage):
		if(hit_box is Hitbox):
			deal_damage(hit_box)

func deal_damage(hit_box: Area2D) -> void:
	var total_dmg: float = 0.0
	total_dmg = hit_box.damage * (100-damage_reduction)/100
	health.set_health(health.health - total_dmg)
	received_damage.emit(total_dmg)
	print("took dmg: ", total_dmg)
	effects = hit_box.get_effects()
	apply_effect(total_dmg)
	if(hit_box.pierce):
		hit_box.pierce.set_pierce(hit_box.pierce.get_pierce() - pierce)

func apply_effect(dmg: float) -> void:
	if(!effects.is_empty()):
		var dot: float = 0.0
		var m_speed_modifier: float = 1.0
		var atk_speed_modifier: float = 1.0
		var zap_stacks: int = 0
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
					if(dmg / 2 > 5):
						explosion.damage = dmg / 2
					else:
						explosion.damage = 5
					main.add_child.call_deferred(explosion)
				Globals.EFFECTS.ZAP:
					zap_stacks = zap_stacks + 1
		dot = 0 - dot
		atk_speed_modifier = 2 - atk_speed_modifier
		health.set_regen(dot)
		enemy.SPEED = enemy.SPEED * m_speed_modifier
		enemy.cooldown = enemy.cooldown * atk_speed_modifier
		if(zap_stacks):
			var zap: Zap = zap_scene.instantiate()
			zap.global_position = enemy.global_position
			zap.stacks = zap_stacks
			main.add_child.call_deferred(zap)
			zap.damage = (dmg/2)+(get_tree().get_first_node_in_group("Player").velocity.length()/100)+damage_reduction
			zap_cooldown_timer = Timer.new()
			zap_cooldown_timer.one_shot = true
			add_child(zap_cooldown_timer)
			zap_cooldown_timer.timeout.connect(self_destruct)
			zap_cooldown_timer.set_wait_time(zap_cooldown)
			zap_cooldown_timer.start()

func self_destruct() -> void:
	if(effects.has(Globals.EFFECTS.ZAP)):
		for i in range(effects.size()-1):
			if(effects[i] == Globals.EFFETCS.ZAP):
				effects.remove_at(i)
	print_debug(effects)
