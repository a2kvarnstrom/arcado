class_name EnemyWave
extends State

@export var waves: Array[Wave]

@export var progress: ProgressBar
@export var progress_text: Label
@export var wave_counter: Label
@export var seq_counter: Label
@export var max_wave_counter: Label
@export var max_seq_counter: Label

var time: float

var spawn_timer: float
var wave_timer: float
var current_wave: int = 0
var current_sequence: EnemySequence
var seq_id: int = 0

var amount_left: int
var time_left: float

var enemy_list: Array = [
	preload("res://scenes/square_enemy.tscn"),
	preload("res://scenes/circle_enemy.tscn"),
	preload("res://scenes/triangle_enemy.tscn")
]

var enum_enemies: Dictionary = {
	0: Global.ENEMIES["RED_SQUARE"],
	1: Global.ENEMIES["BLUE_CIRCLE"],
	2: Global.ENEMIES["GREEN_TRIANGLE"]
}

func enter() -> void:
	amount_left = waves[current_wave].enemy_sequences[seq_id].amount
	time_left = waves[current_wave].enemy_sequences[seq_id].time
	time = waves[current_wave].get_total_wave_time()
	wave_timer = time
	progress.max_value = wave_timer
	print("wave timer " + str(wave_timer))

func update(delta: float) -> void:
	wave_counter.text = "Wave: " + str(current_wave + 1)
	seq_counter.text = "Seq: " + str(seq_id)
	wave_timer -= delta
	progress.value = wave_timer
	progress_text.text = str("%.2f" % (progress.value)) + "/" + str("%.2f" % (progress.max_value)) + " seconds left"
	max_wave_counter.text = "Max Waves: " + str(waves.size())
	max_seq_counter.text = "Max Seq: " + str(waves[current_wave].enemy_sequences.size()-1)

func physics_update(_delta: float) -> void:
	spawn_enemy()

func spawn_enemy():
	# some variables
	seq_id = waves[current_wave].current_sequence
	current_sequence = waves[current_wave].enemy_sequences[seq_id]
	# spawn logic
	if(time_left <= 0):
		# spawn pos
		var enemy_position: Vector2 = Vector2(randf_range(-1000, 1000), randf_range(-600, 600))
		while(enemy_position.x < 640 && enemy_position.x > -80 && enemy_position.y < 360 && enemy_position.y > -45):
			enemy_position = Vector2(randf_range(-960, 960), randf_range(-540, 540))
		
		# instance enemy
		var instance: Node = enemy_list[current_sequence.enemy].instantiate()
		instance.position = enemy_position
		add_child(instance)
		
		# other variable logic
		amount_left -= 1
		time_left = current_sequence.time / current_sequence.amount 
	else:
		time_left -= get_process_delta_time()
	
	if(amount_left == 0):
		waves[current_wave].current_sequence += 1
		amount_left = current_sequence.amount
		if(waves[current_wave].current_sequence >= waves[current_wave].enemy_sequences.size()):
			waves[current_wave].current_sequence = 0
			current_wave += 1
			seq_id = 0
			#waves[current_wave].current_sequence = 0
			if(current_wave >= waves.size()):
				var xtra_wave: Wave = Wave.new()
				var xtra_wave_enemy_sequences: Array[EnemySequence] 
				for i in range(randi_range(1, 5)):
					var temp_sequence: EnemySequence = EnemySequence.new()
					temp_sequence.amount = randi_range(1, 5)
					temp_sequence.time = temp_sequence.amount * randf_range(0.5, 3)
					temp_sequence.enemy = enum_enemies[randi_range(0, 2)]
					xtra_wave_enemy_sequences.push_back(temp_sequence)
				xtra_wave.enemy_sequences = (xtra_wave_enemy_sequences)
				waves.push_back(xtra_wave)
			transitioned.emit(self, "GameIdle")

func restart():
	transitioned.emit(self, "GameStart")
	current_wave = 0
