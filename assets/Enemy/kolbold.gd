extends CharacterBody2D

@export var speed = 80
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	var direction = position.direction_to(player.position)
	velocity = direction * speed
	move_and_slide()
