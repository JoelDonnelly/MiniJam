extends CharacterBody2D

@export var speed: int = 250
@export var dash_modifier: float = 15

@export var dash_duration: float:
	get:
		return $DashDurationTimer.wait_time
	set(value):
		$DashDurationTimer.wait_time = value

@export var dash_cooldown: float:
	get:
		return $DashCooldownTimer.wait_time
	set(value):
		$DashCooldownTimer.wait_time = value

var is_dashing: bool:
	get:
		return not $DashDurationTimer.is_stopped()

var can_dash: bool:
	get:
		return $DashCooldownTimer.is_stopped()


func get_input(delta : float):
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
	
	if Input.is_action_just_pressed("ability_dash") and can_dash:
		$DashDurationTimer.start()
		$DashCooldownTimer.start()
		velocity *= dash_modifier


func _physics_process(delta : float):
	if not is_dashing:
		get_input(delta)
	move_and_slide()
