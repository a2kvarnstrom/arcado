class_name Hurtbox
extends Area2D

signal received_damage(damage: float)

@onready var hitbox: Hitbox
@export var health: Health
@export var pierce: int = 1
@export var damage_reduction: float = 0.0

var can_take_damage: bool = true

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit_box: Area2D) -> void:
	if(hit_box != null && can_take_damage):
		if(hit_box is Hitbox):
			health.set_health(health.health - (hit_box.damage * ((100-damage_reduction)/100)))
			received_damage.emit(hit_box.damage)
			if(hit_box.pierce):
				hit_box.pierce.set_pierce(hit_box.pierce.get_pierce() - pierce)
