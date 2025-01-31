class_name Wave
extends Resource

@export var enemy_sequences: Array[EnemySequence]
@export var current_sequence: int = 0

func get_total_wave_time() -> float:
	var total_wave_time: float = 0.0
	for enemy_sequence in enemy_sequences:
		var sequence_time: float
		sequence_time = enemy_sequence.get_total_time()
		total_wave_time += sequence_time
	return total_wave_time 
