extends AttackBox


@export var damage : float = 5
@export var windUpDuration : float = 0.1
@export var attackDuration : float = 0.3
@export var recoverDuration : float = 0.1


func _init():
	# set the attack here
	attack = Attack.new()
	attack.damage = damage
	monitorable = false
	monitoring = false
	
func _on_activate_attack():
	$Polygon2D0.visible = true
	monitoring = false
	await get_tree().create_timer(windUpDuration).timeout
	$Polygon2D0.visible = false
	$Polygon2D1.visible = true
	$Polygon2D2.visible = true
	monitoring = true
	await get_tree().create_timer(attackDuration).timeout
	$Polygon2D1.visible = false
	monitoring = false
	await get_tree().create_timer(recoverDuration).timeout
	$Polygon2D2.visible = false
	
	

	

