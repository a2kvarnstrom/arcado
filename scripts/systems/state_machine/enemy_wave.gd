class_name EnemyWave
extends State

@export var waves: Array[Wave]

@export var progress: ProgressBar
@export var progress_text: Label
@export var wave_counter: Label

var time: float

var spawn_timer: float
var wave_timer: float
var current_wave: int = 0
var current_sequence: EnemySequence

var amount_left: int
var time_left: float

var enemy_list: Array = [
	preload("res://scenes/square_enemy.tscn"),
	preload("res://scenes/circle_enemy.tscn"),
	preload("res://scenes/triangle_enemy.tscn"),
	preload("res://scenes/pink_ring.tscn"),
	preload("res://scenes/yellow_triangle.tscn"),
	preload("res://scenes/purple_hexagon.tscn"),
	preload("res://scenes/orange_square.tscn")
]

var enum_enemies: Dictionary = {
	0: Global.ENEMIES["RED_SQUARE"],
	1: Global.ENEMIES["BLUE_CIRCLE"],
	2: Global.ENEMIES["GREEN_TRIANGLE"],
	3: Global.ENEMIES["PINK_RING"],
	4: Global.ENEMIES["YELLOW_TRIANGLE"],
	5: Global.ENEMIES["PURPLE_HEXAGON"],
	6: Global.ENEMIES["ORANGE_SQUARE"]
}

func enter() -> void:
	current_sequence = waves[current_wave].get_current_sequence()
	amount_left = current_sequence.amount
	time_left = current_sequence.time / amount_left
	time = waves[current_wave].get_total_wave_time()
	wave_timer = time
	progress.max_value = wave_timer
	spawn_timer = current_sequence.get_time() / current_sequence.get_amount()

func update(delta: float) -> void:
	wave_counter.text = "Wave: " + str(current_wave + 1)
	wave_timer -= delta
	progress.value = wave_timer
	progress_text.text = str("%.2f" % (progress.value)) + "/" + str(int(progress.max_value)) + " seconds left"

func physics_update(delta: float) -> void:
	if(amount_left == 0):
		update_wave()
	else:
		spawn_enemy(delta)

func update_wave() -> void:
	current_sequence = waves[current_wave].get_current_sequence()
	
	#new wave
	if(waves[current_wave].current_sequence >= waves[current_wave].enemy_sequences.size()-1):
		current_wave += 1
		
		if(current_wave >= waves.size()): create_random_wave()
		
		current_sequence = waves[current_wave].get_current_sequence()
		amount_left = current_sequence.amount
		transitioned.emit(self, "GameIdle")
		return
	
	#new sequence
	waves[current_wave].current_sequence += 1
	current_sequence = waves[current_wave].get_current_sequence()
	amount_left = current_sequence.amount
	spawn_timer = current_sequence.get_time() / current_sequence.get_amount()

func spawn_enemy(delta: float) -> void:
	if(spawn_timer <= 0):
		var instance: CharacterBody2D = enemy_list[current_sequence.enemy].instantiate()
		instance.global_position = Vector2(randf_range(-960, 960), randf_range(-540, 540))
		add_child(instance)
		amount_left -= 1
		spawn_timer = current_sequence.get_time() / current_sequence.get_amount()
	else:
		spawn_timer -= delta

func create_random_wave() -> void:
	var xtra_wave: Wave = Wave.new()
	for i in range(randi_range(1, 5)):
		var temp_sequence: EnemySequence = EnemySequence.new()
		temp_sequence.amount = randi_range(1, 5)
		temp_sequence.time = temp_sequence.amount * randf_range(0.5, 3)
		temp_sequence.enemy = enum_enemies[randi_range(0, enemy_list.size()-1)]
		xtra_wave.enemy_sequences.push_back(temp_sequence)
	waves.push_back(xtra_wave)

func restart():
	transitioned.emit(self, "GameStart")
	current_wave = 0
