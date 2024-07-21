extends Node2D

@export var health_component : HealthComponent :
	set(val):
		health_component = val
		get_perc_from_component()
		
var health_perc : float = 1.0:
	set(val):
		health_perc = val
		change_health_bar()

func _process(_delta):
	if health_component:
		get_perc_from_component()


func get_perc_from_component():
	var h_p = health_component.get_percent()
	health_perc = clamp(h_p, 0.0, 1.0)
	
func change_health_bar():
	$healthFilled.scale.x = health_perc
	if health_perc == 1.0:
		visible = false
	else:
		visible = true
	
	
