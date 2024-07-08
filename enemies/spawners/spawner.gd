extends StaticBody2D

class_name Spawner

@export var spawn_timer : Timer
@export var spawn_area : PathFollow2D
@export var mob : PackedScene

var is_active = true

func _process(delta):
	spawn()

func spawn():
	if $spawn_timer.is_stopped() and is_active:
		var new_mob = mob.instantiate()
		new_mob.global_position = get_spawn_position()
		get_parent().add_child(new_mob)
		$spawn_timer.start()

func get_spawn_position():
	spawn_area.progress_ratio =  randf()
	var pos_1  = spawn_area.global_position
	spawn_area.progress_ratio =  randf()
	var pos_2  = spawn_area.global_position
	return Vector2(randi_range(pos_1.x, pos_2.x), randi_range(pos_1.y, pos_2.y))

func _on_spawn_timer_timeout():
	pass # Replace with function body.

func _on_active_area_body_entered(body):
	is_active = true

func _on_active_area_body_exited(body):
	is_active = false
