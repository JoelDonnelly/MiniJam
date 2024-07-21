extends Node2D

var battleMusicFadeInTime : float = 2
var battleMusicActive : bool = false


func _on_enemy_start_chase():
	battleMusicActive = true
	
func _ready():
	$AudioBackground.play()
	$AudioBattle.volume_db = -80
	$AudioBattle.play()
	
	
func _process(delta):
	if battleMusicActive:
		$AudioBattle.volume_db = move_toward($AudioBattle.volume_db,-3,80*delta/battleMusicFadeInTime)
	else:
		$AudioBattle.volume_db = move_toward($AudioBattle.volume_db,-80,80*delta/battleMusicFadeInTime)
	
