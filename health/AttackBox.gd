extends Area2D

class_name AttackBox

signal hit(HB : HitBox)

var attack : Attack

func _init():
	monitorable = false

func _ready():
	area_entered.connect(_on_area_enter_attack)
	if !attack:
		attack = Attack.new()

func _on_area_enter_attack(area : Area2D):
	if area is HitBox:
		area.on_hit(attack)
		hit.emit(area)

func _on_activate_attack():
	pass
