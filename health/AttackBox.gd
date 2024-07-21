extends Area2D

class_name AttackBox

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
