extends CharacterBody2D

signal playerdied

var speed: int = 250
var dash_modifier: float = 15

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


func _ready():
	pass


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
	
	if Input.is_action_just_pressed("ability_dash") and $DashCooldownTimer.is_stopped():
		$DashDurationTimer.start()
		$DashCooldownTimer.start()
	
	velocity = velocity.normalized() * speed
	if not $DashDurationTimer.is_stopped():
		velocity *= dash_modifier


func _physics_process(delta : float):
	get_input(delta)
	move_and_slide()


func _on_health_component_out_of_health():
	playerdied.emit()
	print("player died")
	pass # Replace with function body.
