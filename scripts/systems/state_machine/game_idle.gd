class_name GameIdle
extends State

@export var progress: ProgressBar
@export var progress_text: Label
@onready var enemy_count: Node = %EnemyCount

var cooldown: float = 3.0

func enter() -> void:
	cooldown = 3.0
	progress.max_value = enemy_count.enemy_count

func update(delta: float) -> void:
	progress.value = enemy_count.enemy_count
	progress_text.text = str(progress.value) + "/" + str(progress.max_value) + " enemies left"
	if(enemy_count.enemy_count == 0):
		progress.max_value = 3
		progress.value = cooldown
		progress_text.text = str("%.2f" % (progress.value)) + "/" + str(progress.max_value) + " seconds left"
		cooldown -= delta
		if(cooldown <= 0):
			transitioned.emit(self, "EnemyWave")
