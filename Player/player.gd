extends CharacterBody2D

signal playerdied

@export var speed: int = 250
@export var dash_modifier: float = 15
@export var slash_attack : PackedScene

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

var attack_flip = false

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
		$HealthComponent.enable_I()

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


func _physics_process(delta : float):
	if not is_dashing:
		get_input(delta)
	move_and_slide()

func _process(delta : float):
	if velocity.length() == 0:
		$AnimatedSprite2D.play("IdleFront")
	else:
		print(velocity.angle())
		if (velocity.angle() > -PI/3) && (velocity.angle() < PI/3):
			$AnimatedSprite2D.play("walkRight")
		elif (velocity.angle() > PI/3) && (velocity.angle() < 2*PI/3):
			$AnimatedSprite2D.play("walkDown")
		elif (velocity.angle() < -PI/3) && (velocity.angle() > -2*PI/3):
			$AnimatedSprite2D.play("walkUp")
		else:
			$AnimatedSprite2D.play("walkLeft")
		

func _on_health_component_out_of_health():
	playerdied.emit()
	print("player died")


func _on_dash_duration_timer_timeout():
	$HealthComponent.disable_I()
	
