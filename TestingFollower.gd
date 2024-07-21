extends PathFollow2D

@export var speed : float = 100

func _physics_process(delta):
	progress += speed * delta
