extends Control

@onready var options: PackedScene = preload("res://scenes/options.tscn")
@onready var credits: PackedScene = preload("res://scenes/credits.tscn")

func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_button_pressed() -> void:
	var options_menu = options.instantiate()
	get_tree().current_scene.add_child(options_menu)

func _on_credits_button_pressed() -> void:
	var credits_menu = credits.instantiate()
	get_tree().current_scene.add_child(credits_menu)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
