extends Node2D


var battleMusicFadeInTime : float = 2
var battleMusicActive : bool = false


func _ready():
	$AudioLiftMusic.play()
	
func _on_control_start_game():
	$CanvasGroup.visible = false
	
	$AudioLiftMusic.stop()
	$AudioBackground.play()
	$AudioBattle.volume_db = -80
	$AudioBattle.play()
	
func _process(delta):
	if battleMusicActive:
		$AudioBattle.volume_db = move_toward($AudioBattle.volume_db,-3,80*delta/battleMusicFadeInTime)
	else:
		$AudioBattle.volume_db = move_toward($AudioBattle.volume_db,-80,80*delta/battleMusicFadeInTime)
	



func _on_enemy_base_start_chase():
	battleMusicActive = true
	pass # Replace with function body.


