class_name BulletPool
extends Node

@onready var rectangle_bullet: PackedScene = preload("res://scenes/projectile.tscn")
@onready var circle_bullet: PackedScene = preload("res://scenes/circle_projectile.tscn")

var rectangle_bullet_array: Array[Bullet]
var circle_bullet_array: Array[Bullet]

@export var pool_size: int = 2500 # size per type

func _ready() -> void:
	for i in range(pool_size):
		var bullet: Bullet = rectangle_bullet.instantiate()
		bullet.disable()
		rectangle_bullet_array.append(bullet)
		bullet = circle_bullet.instantiate()
		bullet.disable()
		circle_bullet_array.append(bullet)
