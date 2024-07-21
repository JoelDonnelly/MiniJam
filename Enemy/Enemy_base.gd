extends CharacterBody2D

signal startChase
signal targetFound(target : Node2D)

signal enemyDead

@export var patrolPath : Node2D

@export var target : Node2D
	
var is_chasing = false
@export var chaseSpeed : float = 200

var is_patroling = true
@export var patrolSpeed : float = 100

@export var vision_angle : float = PI/6

@export var vision_dist : float = 100
		
		
		
func _ready():
	resetVisionShape()
	$TargetSpray.bullet_parent = get_parent()
	$WaveSpray.bullet_parent = get_parent()
	$SpiralSpray.bullet_parent = get_parent()
	
func on_chase_initiated(char : Node2D) -> void: # connect these to signal
	target = char
	is_chasing = true
	is_patroling = false
	$VisionCone.visible = false
	targetFound.emit(char)
	$AttackTimer.start()
	startChase.emit()
	
func on_chase_canceled() -> void: # connect these to signal 
	target = null
	is_chasing = false
	is_patroling = true

func _physics_process(delta):
	var speed : float = 0
	var direction : Vector2 = Vector2.ZERO 
	if is_chasing && target:
		if (target.position - position).length() > 300:
			direction = position.direction_to(target.position).normalized()
			speed = chaseSpeed
	elif is_patroling && patrolPath:
		direction = position.direction_to(patrolPath.position).normalized()
		speed = patrolSpeed
	
	$VisionCone.rotation = direction.angle()
		
	velocity = direction * speed
	move_and_slide()
	
func _process(delta : float):
	if velocity.length() == 0:
		$AnimatedSprite2D.play("Idle")
	else:
		if ((velocity.angle() < -PI/3) && (velocity.angle() > -2*PI/3)):
			$AnimatedSprite2D.play("WalkUp")
		else:
			$AnimatedSprite2D.play("WalkDown")
			
	
func resetVisionShape() -> void:
	$VisionCone.vision_angle = vision_angle
	$VisionCone.vision_dist = vision_dist
	
	

func _on_health_component_out_of_health():
	enemyDead.emit()
	var deathSpiral = SpiralSpray.new()
	deathSpiral.bullet_parent = get_parent()
	deathSpiral.bullet_scene = preload("res://Enemy/Bullet.tscn")
	get_parent().add_child(deathSpiral)
	deathSpiral.position = position
	deathSpiral.attack()
	queue_free()
	
	pass # Replace with function body.


func _on_attack_timer_timeout():
	var selection = randi_range(0,2)
	if selection == 0:
		$TargetSpray.attack()
	if selection == 1:
		$WaveSpray.attack()
	if selection == 2:
		$SpiralSpray.attack()
	pass # Replace with function body.



