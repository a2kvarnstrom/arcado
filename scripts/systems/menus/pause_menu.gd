extends Control

@onready var menu: VBoxContainer = $VBoxContainer
@onready var options: PackedScene = preload("res://scenes/options.tscn")
@onready var upgrades: PackedScene = preload("res://scenes/upgrades_ui.tscn")

var player: CharacterBody2D

func _ready() -> void:
	$VBoxContainer/Resume.grab_focus()

func resume() -> void:
	queue_free()
	Engine.time_scale = 1.0

func _on_options_button_pressed() -> void:
	menu.visible = false
	var options_menu: Control = options.instantiate()
	add_child(options_menu)

func _on_quit_button_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_upgrades_button_pressed() -> void:
	menu.visible = false
	var upgrades_menu: Control = upgrades.instantiate()
	add_child(upgrades_menu)
