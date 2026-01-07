class_name Health
extends Node

signal max_health_changed(diff: float)
signal health_changed(diff: float)
signal health_depleted

@export var max_health: float = 100.0 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality
@export var health_regen: float = 0.0 : set = set_regen, get = get_regen

var immortality_timer: Timer = null
var regen_timer: Timer = null
var regen_tickrate: float = 2.0

@onready var health: float = max_health : set = set_health, get = get_health

@export var healthbar: ProgressBar
@export var texture_healthbar: TextureProgressBar
   
func _ready() -> void:
	if(healthbar):
		healthbar.max_value = max_health
	if(texture_healthbar):
		texture_healthbar.max_value = max_health
	set_max_health(get_max_health() * Globals.enemy_hp_scaling)
	start_regen_timer()

func _process(_delta: float) -> void:
	if(healthbar != null):
		healthbar.value = health
	if(texture_healthbar != null):
		texture_healthbar.value = health
	if(health_regen != 0 && regen_timer.is_stopped() && health != max_health && health != 0):
		start_regen_timer()

func start_regen_timer() -> void:
	if(regen_timer == null):
		regen_timer = Timer.new()
		regen_timer.one_shot = true
		add_child(regen_timer)
	
	if(!regen_timer.timeout.is_connected(regen)):
		regen_timer.timeout.connect(regen)
	regen_timer.set_wait_time(1 / regen_tickrate)
	regen_timer.start()

func regen() -> void:
	set_health(health + health_regen)

func set_max_health(value: float) -> void:
	var clamped_value: float = 1.0 if value <= 0.0 else value
	
	if(clamped_value != max_health):
		var difference: float = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if(health > max_health):
			health = max_health

func get_max_health() -> float:
	return max_health

func set_immortality(value: bool) -> void:
	immortality = value

func get_immortality() -> bool:
	return immortality

func set_temporary_immortality(time: float) -> void:
	if(immortality_timer == null):
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	
	if(immortality_timer.timeout.is_connected(set_immortality)):
		immortality_timer.timeout.disconnect(set_immortality)
	
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()

func set_health(value: float) -> void:
	if(value < health && immortality):
		return
	
	var clamped_value: float = clampf(value, 0.0, max_health)
	
	if(clamped_value != health):
		var difference: float = clamped_value - value
		health = clamped_value
		
		health_changed.emit(difference)
		
		if(health == 0):
			health_depleted.emit()

func get_health() -> float:
	return health

func set_regen(value: float) -> void:
	health_regen = value

func get_regen() -> float:
	return health_regen
