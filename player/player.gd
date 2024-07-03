extends CharacterBody2D

var speed = 500
var can_shoot: bool = true
var ice_spear = preload("res://projectiles/ice_spear.tscn")

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if Input.is_action_just_pressed("sprint"):
		speed = 600
	if direction.x > 0:
		$Sprite2D.flip_h = true
	elif direction.x <0:
		$Sprite2D.flip_h = false
	
	if velocity.x > 0:
		$Sprite2D.frame = 0
	else:
		toggle_frames()
	
	if Input.is_action_just_pressed("primary") and can_shoot:
		can_shoot = false
		shoot()
		$shoot_timer.start()

func toggle_frames():
	if $Sprite2D.frame == 0:
		$Sprite2D.frame = 1
	else:
		$Sprite2D.frame = 0

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

