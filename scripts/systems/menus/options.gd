extends Control

@onready var shader_toggle: CheckButton = $TabContainer/Video/MarginContainer/VBoxContainer/ShaderToggle
@onready var resolution_option_button: OptionButton = $TabContainer/Video/MarginContainer/VBoxContainer/OptionButton

var resolutions: Dictionary = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1600x900": Vector2i(1600, 900),
	"1440x900": Vector2i(1440, 900),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1024x600": Vector2i(1024, 600),
	"800x600": Vector2i(800, 600)
}

func _ready() -> void:
	add_resolutions()
	update_button_values()

func update_button_values() -> void:
	shader_toggle.set_pressed_no_signal(Globals.shader_state)
	var window_size: String = str(get_window().size.x, "x", get_window().size.y)
	resolution_option_button.selected = resolutions.keys().find(window_size)

func add_resolutions() -> void:
	for i in resolutions:
		resolution_option_button.add_item(i)

func _on_button_pressed() -> void:
	get_node("../").menu.visible = true
	queue_free()

func _on_shader_toggle_toggled(toggled_on: bool) -> void:
	Globals.toggle_shader(toggled_on)

func _on_wave_input_value_changed(value: float) -> void:
	Globals.current_wave = roundi(value)
	Globals.wave_changed = true

func _on_option_button_item_selected(index: int) -> void:
	var key: String = resolution_option_button.get_item_text(index)
	get_window().set_size(resolutions[key])
