extends CharacterBody2D

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
	
func on_chase_initiated(char : Node2D) -> void: # connect these to signal
	target = char
	is_chasing = true
	is_patroling = false
	
func on_chase_canceled() -> void: # connect these to signal 
	target = null
	is_chasing = false
	is_patroling = true

func _physics_process(delta):
	var speed : float = 0
	var direction : Vector2 = Vector2.ZERO 
	if is_chasing && target:
		direction = position.direction_to(target.position).normalized()
		speed = chaseSpeed
	elif is_patroling && patrolPath	:
		direction = position.direction_to(patrolPath.position).normalized()
		speed = patrolSpeed
	
	$VisionCone.rotation = direction.angle()
		
	velocity = direction * speed
	move_and_slide()
	
func resetVisionShape() -> void:
	$VisionCone.vision_angle = vision_angle
	$VisionCone.vision_dist = vision_dist
	
	
