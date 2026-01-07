class_name Weapon
extends Resource

@export var current_weapon: Globals.WEAPONS : get = get_weapon, set = set_weapon
@export var damage_mult: float = 1.0

var atk_speed: float = 2.0
var projectile: Globals.PROJECTILES
var dmg: float = 10
var pierce: int = 1
var lifespan: float = 2.5
var projectile_count: int = 1
var projectile_size: float = 1.0
var projectile_speed: float = 500.0
var current_effects: Array[Globals.EFFECTS]
var angles: Array[float] = [0.0]

var projectile_list: Array = [
	preload("res://scenes/projectile.tscn"),
	preload("res://scenes/circle_projectile.tscn")
]

func get_weapon() -> Globals.WEAPONS:
	return current_weapon

func set_weapon(weapon: Globals.WEAPONS) -> void:
	current_weapon = weapon
	
	match(current_weapon):
		Globals.WEAPONS.REGULAR:
			dmg = 10.0 * damage_mult
			pierce = 1
			projectile = Globals.PROJECTILES.REGULAR
			atk_speed = 2.0
			lifespan = 2.5
			projectile_count = 1
			projectile_size = 1.0
			projectile_speed = 500.0
			angles = [0.0]
		
		Globals.WEAPONS.TRIPLE:
			dmg = 7.5 * damage_mult
			pierce = 1
			projectile = Globals.PROJECTILES.REGULAR
			atk_speed = 2.0
			lifespan = 2.5
			projectile_count = 3
			projectile_size = 1.0
			projectile_speed = 500.0
			angles = [-15.0, 0, 15.0]
		
		Globals.WEAPONS.GROWING:
			dmg = 10.0 * damage_mult
			pierce = 3
			projectile = Globals.PROJECTILES.CIRCLE
			atk_speed = 0.5
			lifespan = 5.0
			projectile_count = 1 
			projectile_size = 0.5
			projectile_speed = 350.0
			angles = [0.0]
		
		Globals.WEAPONS.HEAVY:
			dmg = 20.0 * damage_mult
			pierce = 10
			projectile = Globals.PROJECTILES.CIRCLE
			atk_speed = 0.5
			lifespan = 5.0
			projectile_count = 1
			projectile_size = 2.0
			projectile_speed = 350.0
			angles = [0.0]

func add_effect(effect: Globals.EFFECTS) -> void:
	current_effects.append(effect)

func remove_effect(index: int) -> void:
	current_effects.remove_at(index)

func get_effect() -> Array[Globals.EFFECTS]:
	print(current_effects)
	return current_effects

func shoot(direction: float, proj_pos: Vector2) -> Array[CharacterBody2D]:
	var instance: PackedScene = projectile_list[projectile]
	var instance_array: Array[CharacterBody2D]
	
	for i in range(projectile_count):
		instance_array.append(instance.instantiate())
	
	for i in instance_array:
		i.dir = direction + deg_to_rad(angles[instance_array.find(i)])
		i.spawn_rot = i.dir + deg_to_rad(90)
		i.get_node("Hitbox").effects = current_effects
		i.spawn_pos = proj_pos
		i.zdex = -1
		i.lifespan = lifespan
		i.get_node("Hitbox").set_collision_layer_value(4, true)
		i.get_node("Hitbox").set_collision_layer_value(2, false)
		i.get_node("Hitbox").set_collision_mask_value(3, true)
		i.get_node("Hitbox").set_collision_mask_value(1, false)
		i.dmg = dmg
		i.scale = Vector2(projectile_size, projectile_size)
		i.SPEED = projectile_speed
		i.find_child("Pierce").set_max_pierce(pierce)
		match(current_weapon):
			Globals.WEAPONS.GROWING:
				i.growing = true
				i.can_take_damage = false
				i.homing = false
				i.color = Color.WHITE
			
			Globals.WEAPONS.HEAVY:
				i.can_take_damage = false
				i.homing = false
				i.color = Color.WHITE
	return instance_array
