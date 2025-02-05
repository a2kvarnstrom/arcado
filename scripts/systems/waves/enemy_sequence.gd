class_name EnemySequence
extends Resource

@export var enemy: Global.ENEMIES
@export var amount: int
@export var time: float

func get_time() -> float:
	return time

func get_amount() -> int:
	return amount
