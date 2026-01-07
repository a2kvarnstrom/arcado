class_name Hitbox
extends Area2D

@export var damage: float = 1.0 : set = set_damage, get = get_damage
@export var pierce: Pierce
@export var can_apply_status_effects: bool = true

var effects: Array[Globals.EFFECTS]

func set_damage(value: float) -> void:
	damage = value

func get_damage() -> float:
	return damage

func get_effects() -> Array[Globals.EFFECTS]:
	return effects
