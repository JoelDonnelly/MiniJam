extends Timer

@export var bullet_scene : PackedScene




func _on_timeout():
	var new_bullet : Node2D = bullet_scene.instantiate()
	new_bullet.position = $Marker2D.position
	new_bullet.scale = Vector2(0.5,0.5)
	new_bullet.rotation = randf_range(PI/6, -PI/6)
	add_child(new_bullet)
	pass # Replace with function body.
