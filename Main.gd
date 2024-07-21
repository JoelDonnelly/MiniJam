extends Node2D


var battleMusicFadeInTime : float = 2
var battleMusicActive : bool = false


func _ready():
	$AudioLiftMusic.play()
	
func _on_control_start_game():
	add_child(preload("res://red_level.tscn").instantiate())
	$CanvasGroup.visible = false
	$AudioLiftMusic.stop()
	




func _on_enemy_base_start_chase():
	battleMusicActive = true
	pass # Replace with function body.


