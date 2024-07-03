extends CharacterBody2D

var speed = 500
var can_shoot: bool = true
var ice_spear = preload("res://projectiles/ice_spear.tscn")
@onready var walkTimer = get_node("walk_timer")
@onready var player_image  = get_node("player_image")

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if Input.is_action_just_pressed("sprint"):
		speed = 600
	
	if Input.is_action_just_pressed("primary") and can_shoot:
		can_shoot = false
		shoot()
		$shoot_timer.start()
	
	asset_changes(direction)

func asset_changes(direction):
	if direction.x > 0:
		player_image.flip_h = true
	elif direction.x <0:
		player_image.flip_h = false
	
	if velocity == Vector2.ZERO:
		player_image.frame = 0
	if velocity != Vector2.ZERO:
		if walkTimer.is_stopped():
			toggle_frames()
			walkTimer.start()

func toggle_frames():
	if player_image.frame == 0:
		player_image.frame = 1
	else:
		player_image.frame = 0

func _physics_process(delta):
	get_input()
	move_and_slide()

func shoot():
	var new_attack = ice_spear.instantiate()
	get_parent().add_child(new_attack)
	new_attack.position = position
	new_attack.missile_direction = (position - get_global_mouse_position()).normalized()

func _on_shoot_timer_timeout():
	can_shoot = true



func _on_walk_timer_timeout():
	pass # Replace with function body.
