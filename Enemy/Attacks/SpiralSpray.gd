extends BulletSpray

class_name SpiralSpray

@export var bullets : int = 100
@export var bpr : float = 20
@export var offset : float = 0.5
@export var delay : float = 0.01
var angleInc : float


func _ready():
	angleInc = 2*PI/(bpr) + offset*2*PI/(bpr**2)

	pass
	
func attack():
	var i : int = 0
	var ang : float = 0
	var b : Node2D 
	while i < bullets:
		await get_tree().create_timer(delay).timeout
		b = spawn_bullet(ang)
		i += 1
		ang += angleInc
		
