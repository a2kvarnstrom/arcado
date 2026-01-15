class_name BulletPool
extends Node

@onready var rectangle_bullet: PackedScene = preload("res://scenes/projectile.tscn")
@onready var circle_bullet: PackedScene = preload("res://scenes/circle_projectile.tscn")

var rectangle_bullet_in_use: Array[Bullet]
var rectangle_bullet_available: Array[Bullet]

var circle_bullet_in_use: Array[Bullet]
var circle_bullet_available: Array[Bullet]

@export var pool_size: int = 2500 # size per bullet type

func _ready() -> void:
	for i in range(pool_size):
		var bullet: Bullet = rectangle_bullet.instantiate()
		bullet.enter()
		bullet.disable()
		rectangle_bullet_available.append(bullet)
		bullet = circle_bullet.instantiate()
		bullet.enter()
		bullet.disable()
		circle_bullet_available.append(bullet)

func spawn_bullet(type: Globals.PROJECTILES, pos: Vector2, dir: Vector2, damage: float, z_index: int) -> Bullet:
	var bullet: Bullet
	match(type):
		Globals.PROJECTILES.REGULAR:
			if(rectangle_bullet_available.is_empty()):
				return null
			bullet = rectangle_bullet_available.pop_front()
			rectangle_bullet_in_use.append(bullet)
		Globals.PROJECTILES.CIRCLE:
			if(circle_bullet_available.is_empty()):
				return null
	
	if(bullet):
		bullet.enable(pos, dir, damage, z_index)
		
		return bullet
	return null
