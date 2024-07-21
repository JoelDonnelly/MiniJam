extends CharacterBody2D

var speed = 250


func _ready():
	pass


func get_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed


func _physics_process(delta : float):
	get_input()
	move_and_slide()
