extends BulletSpray

class_name TargetSpray

@export var target : Node2D
@export var bullets : int = 10
@export var angleRange : float = PI/6
@export var delay : float = 0.01

func _ready():
	attack()
	pass
	
func attack():
	var i : int = 0
	var accuracy : float
	var b : Node2D 
	while i < bullets:
		await get_tree().create_timer(delay).timeout
		accuracy = randf_range(-angleRange/2,angleRange/2)
		
		b = spawn_bullet(accuracy + get_angle_to(target.position))
		i += 1

		
