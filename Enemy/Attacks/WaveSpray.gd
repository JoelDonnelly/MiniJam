extends BulletSpray

class_name WaveSpray
@export var target : Node2D
@export var bullets_in_wave : int = 5
@export var waves : int = 3
@export var total_angle : float = PI/6
@export var wave_delay : float = 0.7

var start_ang : float
var step_ang : float

func _ready():
	start_ang = -total_angle/2
	step_ang = total_angle/bullets_in_wave

	
func attack():
	var ib : int = 0
	var iw : int = 0
	var ang : float = start_ang
	var b : Node2D 
	while iw < waves:
		while ib < bullets_in_wave:
			b = spawn_bullet(ang + get_angle_to(target.position))
			ang += step_ang
			ib += 1
		ib = 0
		ang = start_ang
		iw += 1
		await get_tree().create_timer(wave_delay).timeout

func set_target(t : Node2D):
	target = t
