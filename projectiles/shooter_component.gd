extends Node2D


const bullet_scene = preload("res://projectiles/bullet.tscn")


@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
	
@export var rotation_speed = 100
@export var shooter_wait_time = 0.15
@export var spawn_points_count = 3

const radius = 20

func _ready():
	var step = 2 * PI / spawn_points_count

	
	for i in range(spawn_points_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius,0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
		
	shoot_timer.wait_time = shooter_wait_time
	shoot_timer.start()

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotation_speed * delta
	rotater.rotation_degrees = fmod(new_rotation,360)

func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		
