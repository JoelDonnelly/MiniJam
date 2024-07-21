extends CharacterBody2D

@export var patrolPath : Node2D

@export var target : Node2D
	
var is_chasing = false
var chaseSpeed : float = 200

var is_patroling = true
var patrolSpeed : float = 100

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
		direction = position.direction_to(target.position)
		speed = chaseSpeed
	elif is_patroling && patrolPath	:
		direction = position.direction_to(patrolPath.position)
		speed = patrolSpeed
		
	velocity = direction * speed * delta
	move_and_slide()
	
func resetVisionShape() -> void:
	var p1 : Vector2 = Vector2.ZERO
	var p2 : Vector2 = Vector2(vision_dist*cos(vision_angle/2),vision_dist*sin(vision_angle/2))
	var p3 : Vector2 = Vector2(vision_dist*cos(vision_angle/2),-vision_dist*sin(vision_angle/2))
	var visionCone : PackedVector2Array = PackedVector2Array([p1,p2,p3])
	
	$DetectionArea/CollisionPolygon2D.polygon = visionCone
	$DetectionArea/Polygon2D.polygon = visionCone
	
	
