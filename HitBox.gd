extends Area2D

class_name HitBox

@export var initialise_disabled = false
var setValue_monitoring = monitoring
var setValue_monitorable = monitorable

func _init():
	if initialise_disabled:
		monitoring = false
		monitorable = false
	pass

func post_init_enable():
	if initialise_disabled:
		monitoring = setValue_monitoring
		monitorable = setValue_monitorable
	
func _ready():
	connect("area_entered",_on_area_entered)


func _on_area_entered(area):
	get_parent().hit_by(area)
	pass # Replace with function body.
