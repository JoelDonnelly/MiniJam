extends Node2D

class_name BulletSpray

@export var bullet_scene : PackedScene
@export var bullet_parent : Node2D

func attack():
	pass
	
func spawn_bullet(ang: float) -> Node2D:
	var b = bullet_scene.instantiate()
	b.scale = Vector2(0.5,0.5)
	b.rotation = ang
	bullet_parent.add_child(b)
	return b
	
