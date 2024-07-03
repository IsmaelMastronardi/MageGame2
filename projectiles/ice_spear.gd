extends Area2D


var speed = 500
var missile_direction

func _process(delta):
	position -= missile_direction * speed * delta
	$IceSpear.rotation = missile_direction.angle() + deg_to_rad(135)
