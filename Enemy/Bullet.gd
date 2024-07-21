extends CharacterBody2D

@export var bullet_speed : float = 150
@export var bullet_damage : float = 1

func _physics_process(delta):
	velocity = Vector2(bullet_speed*delta,0).rotated(rotation)
	var col : KinematicCollision2D = move_and_collide(velocity)
	if col:
		queue_free()
	
		


func _on_attack_box_hit(HB):
	queue_free()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
