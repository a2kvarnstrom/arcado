class_name GameIdle
extends State

@export var progress: ProgressBar
@export var progress_text: Label
@onready var enemy_count: Node = %EnemyCount

func enter() -> void:
	progress.max_value = enemy_count.enemy_count

func update(_delta: float) -> void:
	progress.value = enemy_count.enemy_count
	progress_text.text = str(progress.value) + "/" + str(progress.max_value) + " enemies left"
	if(enemy_count.enemy_count == 0):
		transitioned.emit(self, "EnemyWave")
