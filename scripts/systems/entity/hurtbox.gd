class_name Hurtbox
extends Area2D

signal received_damage(damage: float)

@onready var hitbox: Hitbox
@export var health: Health
@export var pierce: int = 1

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit_box: Area2D) -> void:
	if(hit_box != null):
		if(hit_box is Hitbox):
			health.set_health(health.health - hit_box.damage)
			received_damage.emit(hit_box.damage)
			if(hit_box.pierce):
				hit_box.pierce.set_pierce(hit_box.pierce.get_pierce() - pierce)
