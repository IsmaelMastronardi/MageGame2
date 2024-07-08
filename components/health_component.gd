extends Node

class_name HealthComponent

@export var health_bar : ProgressBar
@export var health: int

func _ready():
	health_bar.value = health

func take_damage(damage):
	health -= damage
	set_heatlh_bar()
	print(health)
	if health <= 0:
		var entity = get_parent()
		if entity.is_in_group("player"):
			get_tree().paused = true
		else:
			entity.queue_free()


func set_heatlh_bar():
	health_bar.value = health
