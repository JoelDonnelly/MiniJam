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

@export var slash_attack : PackedScene

var attack_flip = false

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
	
	if Input.is_action_just_pressed("ability_attack"):
		var slash_node : AttackBox = slash_attack.instantiate()
		var dir = global_position.direction_to(get_global_mouse_position())
		if attack_flip:
			slash_node.scale.y = slash_node.scale.y * -1
			attack_flip = false
		else:
			attack_flip = true
		slash_node.position = dir * 400
		slash_node.rotation = dir.angle()
		add_child(slash_node)

		slash_node._on_activate_attack()
	
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
