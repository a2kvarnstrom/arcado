class_name GameIdle
extends State

@export var progress: ProgressBar
@export var progress_text: Label
@onready var enemy_count: Node = %EnemyCount

@export var max_cooldown: float = 3.0
var cooldown = max_cooldown

func enter() -> void:
	cooldown = 3.0
	progress.max_value = enemy_count.enemy_count

func update(delta: float) -> void:
	if(enemy_count.enemy_count != 0):
		progress.value = enemy_count.enemy_count
		progress_text.text = str(int(progress.value)) + "/" + str(int(progress.max_value)) + " enemies left"
	else:
		progress.max_value = max_cooldown
		progress.value = cooldown
		progress_text.text = str("%.2f" % (progress.value)) + "/" + str(int(progress.max_value)) + " seconds left"
		cooldown -= delta
		if(cooldown <= 0):
			transitioned.emit(self, "EnemyWave")
