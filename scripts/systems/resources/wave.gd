class_name Wave
extends Resource

@export var enemy_sequences: Array[EnemySequence]
@export var current_sequence: int = 0

func get_total_wave_time() -> float:
	var total_wave_time: float = 0.0
	for i in enemy_sequences:
		total_wave_time += i.get_time()
	return total_wave_time

func get_total_enemy_count() -> int:
	var total_enemy_count: int = 0
	for i in enemy_sequences:
		total_enemy_count += i.get_amount()
	return total_enemy_count

func get_current_sequence() -> EnemySequence:
	return enemy_sequences[current_sequence]
