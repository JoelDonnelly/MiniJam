extends Node
class_name HealthComponent

signal out_of_health
signal healed(ammount : float)
signal damaged(ammount : float)
signal fully_healed

var I_enabled = false

@export var max_health : float = 100

@export var health : float = 100:
	set(val):
		if (val <= 0) && (health > 0): 
			health = val
			out_of_health.emit()
		elif val >= max_health: 
			health = val
			fully_healed.emit()
		else:
			health = val

func recieve_damage(damage : float, allow_over_flow : bool = false) -> void:
	var damage_applied = damage
	if allow_over_flow == false:
		damage_applied = min(damage, health)
	if I_enabled:
		damage_applied = 0
	health -= damage_applied
	damaged.emit(damage_applied)

func recieve_healing(heal : float, allow_over_flow : bool = false) -> void:
	var heal_applied = heal
	if allow_over_flow == false:
		heal_applied = min(heal, max_health-health)
	health += heal_applied
	healed.emit(heal_applied)
	
func set_health(value : float) -> void:
	if value > health:
		healed.emit(value-health)
	elif value < health:
		damaged.emit(health-value)
	health = value

func enable_I():
	I_enabled = true
	
func disable_I():
	I_enabled = false
	
func timed_enable_I(duration : float):
	enable_I()
	await get_tree().create_timer(duration).timeout
	disable_I()

func reset_health() -> void:
	set_health(max_health)

func get_percent() -> float:
	return (health/max_health)

func get_health() -> float:
	return health
func get_slash_string() -> String:
	return "%s/%s" % [health, max_health]
