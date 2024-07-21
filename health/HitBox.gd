extends Area2D

class_name HitBox

@export var hp : HealthComponent


func _init():
	monitoring = false
	
func _ready():
	pass

func on_hit(attack: Attack):
	if hp:
		hp.recieve_damage(attack.damage)
	
	# do other things based on the attack
	# stun
	# knockback
	pass

