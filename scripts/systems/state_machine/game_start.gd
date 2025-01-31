class_name GameStart
extends State

@export var progress: ProgressBar
@export var progress_text: Label

var cooldown: float = 3.0

func enter() -> void:
	progress.max_value = cooldown

func update(delta: float) -> void:
	cooldown -= delta
	progress.value = cooldown
	progress_text.text = str("%.2f" % (progress.value)) + "/" + str(progress.max_value) + " seconds left"
	if(cooldown <= 0):
		progress.visible = true
		progress_text.visible = true
		transitioned.emit(self, "EnemyWave")
