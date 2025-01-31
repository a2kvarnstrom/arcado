extends Node

@export var enemy_count: int = 0

func _on_enemy_wave_child_exiting_tree(_node: Node) -> void:
	enemy_count -= 1

func _on_enemy_wave_child_entered_tree(_node: Node) -> void:
	enemy_count += 1
