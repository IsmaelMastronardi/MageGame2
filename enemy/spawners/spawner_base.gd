extends StaticBody2D

@onready var enemy = preload("res://assets/Enemy/kolbold.tscn")
var is_active = false

func _process(delta):
	spawn()

func spawn():
	if $spawn_timer.is_stopped() and is_active:
		var new_enemy = enemy.instantiate()
		new_enemy.position = get_spawn_position()
		get_parent().add_child(new_enemy)
		$spawn_timer.start()

func get_spawn_position():
	$spawn_area/PathFollow2D.progress_ratio =  randf()
	return $spawn_area/PathFollow2D.global_position

func _on_spawn_timer_timeout():
	pass # Replace with function body.

func _on_active_area_body_entered(body):
	is_active = true

func _on_active_area_body_exited(body):
	is_active = false
