extends Control

@onready var shader_toggle: CheckButton = $TabContainer/Video/MarginContainer/ShaderToggle

func _ready() -> void:
	shader_toggle.set_pressed_no_signal(Globals.shader_state)

func _on_button_pressed() -> void:
	get_node("../").menu.visible = true
	queue_free()

func _on_shader_toggle_toggled(toggled_on: bool) -> void:
	Globals.toggle_shader(toggled_on)


func _on_wave_input_value_changed(value: float) -> void:
	Globals.current_wave = roundi(value)
	Globals.wave_changed = true
