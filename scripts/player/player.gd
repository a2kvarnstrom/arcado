class_name Player 
extends CharacterBody2D

@onready var health: Health = $Health
@onready var circle: Node2D = $circle
@onready var label: Label = %deathhaha
@onready var main: Node2D = $".."
@onready var death_reset: Timer = $DeathReset
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var fps_counter: Label = $"../CanvasLayer/FpsCounter"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var pause_menu: PackedScene = preload("res://scenes/pause_menu.tscn")

@export var SPEED: float = 300.0
@export var weapon: Weapon

var projectile = load("res://scenes/projectile.tscn")
var shoot_cooldown: float = 0.0
var radius: float = 80.0
var angle: float = 0.0
var spin_speed: float = 0.0
var dmg: float = 10
var d_res: float = 0.0
var iframes: float = 0.0

func _process(delta: float) -> void:
	fps_counter.text = "FPS: " + str(Engine.get_frames_per_second())
	if(iframes > 0):
		iframes -= delta
	else:
		hurtbox.damage_reduction = d_res
	circular_motion()
	
	if(spin_speed <= 3.0):
		spin_speed += delta * 3
	
	if(Input.is_action_just_pressed("shoot") && Engine.time_scale == 1):
		shoot()
	
	if(shoot_cooldown > 0):
		shoot_cooldown -= delta
	
	if(Input.is_action_just_pressed("pause")):
		pause()

func _physics_process(delta: float) -> void:
	delta *= 60
	var x_vel: float = Input.get_axis("left", "right")
	var y_vel: float = Input.get_axis("up", "down")
	if(y_vel < 0):
		velocity.y = -SPEED * delta
	elif(y_vel > 0):
		velocity.y = SPEED * delta 
	else:
		velocity.y = 0
	
	if(x_vel > 0):
		velocity.x = SPEED * delta
	elif(x_vel < 0):
		velocity.x = -SPEED * delta
	else:
		velocity.x = 0
	if(Engine.time_scale == 1.0):
		move_and_slide()

func shoot() -> void:
	if(shoot_cooldown > 0.0):
		return
	
	var direction: float = (circle.global_position - global_position).angle() + deg_to_rad(90)
	
	var projectiles: Array = weapon.shoot(direction, circle.global_position)
	for i in projectiles:
		main.add_child.call_deferred(i)
	
	shoot_cooldown = 1/weapon.atk_speed
	spin_speed = 0.3

func circular_motion():
	angle += spin_speed * get_process_delta_time()
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	
	circle.position = Vector2(radius * x_pos, radius * y_pos)

func pause() -> void:
	Engine.time_scale = !Engine.time_scale

	if(Engine.time_scale != 1.0):
		var menu: Control = pause_menu.instantiate()
		canvas_layer.add_child(menu)
	else:
		var menu: Control = canvas_layer.get_node("./PauseMenu")
		menu.resume()

func _draw() -> void:
	draw_circle(Vector2(0,0), 55.0, Color.WHITE, true, -1.0, true)
	draw_circle(Vector2(0,0), 80.0, Color.WEB_GRAY, false, 7.0, true)

func _on_health_health_depleted() -> void:
	label.visible = true
	Engine.time_scale = 0.5
	death_reset.start()

func _on_death_reset_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_health_health_changed(_diff: float) -> void:
	hurtbox.damage_reduction = 100.0
	iframes = 1
