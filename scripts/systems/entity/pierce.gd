class_name Pierce
extends Node

signal pierce_changed(diff: int)
signal max_pierce_changed(diff: int)
signal pierce_depleted

@export var max_pierce: int = 1 : set = set_max_pierce, get = get_max_pierce

@onready var pierce: int = max_pierce : set = set_pierce, get = get_pierce

func get_max_pierce() -> int:
	return max_pierce

func set_max_pierce(value: int) -> void:
	max_pierce_changed.emit(max_pierce-value)
	max_pierce = value

func get_pierce() -> int:
	return pierce

func set_pierce(value: int) -> void:
	pierce_changed.emit(pierce-value)
	pierce = value
	if(pierce <= 0):
		pierce_depleted.emit()
