class_name Hitbox
extends Area2D

@export var damage: float = 1.0 : set = set_damage, get = get_damage
@export var pierce: Pierce

func set_damage(value: float) -> void:
	damage = value

func get_damage() -> float:
	return damage	
