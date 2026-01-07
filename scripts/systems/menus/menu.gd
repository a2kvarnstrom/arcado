extends Control

@onready var options: PackedScene = preload("res://scenes/options.tscn")
@onready var credits: PackedScene = preload("res://scenes/credits.tscn")
@onready var menu: VBoxContainer = $VBoxContainer

var add_world_env_node: bool = true

func _ready() -> void:
	$VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	Globals.started = true

func _on_options_button_pressed() -> void:
	var options_menu = options.instantiate()
	get_tree().current_scene.add_child(options_menu)
	menu.visible = false

func _on_credits_button_pressed() -> void:
	var credits_menu = credits.instantiate()
	get_tree().current_scene.add_child(credits_menu)
	menu.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
