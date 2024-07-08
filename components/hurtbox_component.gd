extends Area2D

class_name HurtBoxComponent

@export var hurtbox : CollisionShape2D
@export var health_component: HealthComponent
@export var invincibiility_timer : Timer

func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBoxComponent) -> void:
	if hitbox != null and invincibiility_timer.is_stopped():
		health_component.take_damage(hitbox.damage)
		invincibiility_timer.start()
