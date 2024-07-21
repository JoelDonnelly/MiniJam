extends CharacterBody2D

@export var bullet_speed : float = 150
@export var bullet_damage : float = 1

func _physics_process(delta):
	velocity = Vector2(bullet_speed*delta,0).rotated(rotation)
	var col : KinematicCollision2D = move_and_collide(velocity)
	while col:
		if col.get_collider() is Node2D:
			var body : Node2D = col.get_collider()
			if body.has_method("hit"):
				body.hit(bullet_damage)
				self.queue_free()
			else:
				add_collision_exception_with(col.get_collider())
		else:
			add_collision_exception_with(col.get_collider())
		col = move_and_collide(col.get_remainder())
		
