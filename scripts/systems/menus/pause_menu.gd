extends Control

@onready var menu: VBoxContainer = $VBoxContainer
@onready var options: PackedScene = preload("res://scenes/options.tscn")
@onready var upgrades: PackedScene = preload("res://scenes/upgrades_ui.tscn")
@onready var shader: ColorRect = $ColorRect


var player: CharacterBody2D

func _ready() -> void:
	$VBoxContainer/Resume.grab_focus()

func resume() -> void:
	queue_free()
	Engine.time_scale = 1.0
	if(!Globals.shader_state && get_tree().root.get_child(2).has_node("WorldEnvironment")):
		get_tree().root.get_child(2).get_node("./WorldEnvironment").queue_free()
	elif(!get_tree().root.get_child(2).has_node("./WorldEnvironment") && Globals.shader_state):
		get_tree().root.get_child(2).add_child.call_deferred(load("res://scenes/world_environment.tscn").instantiate())

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
