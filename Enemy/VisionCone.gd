extends Area2D

signal target_entered_vision(node:Node2D)
signal target_exited_vision()

@export var target_group : StringName

@export var vision_dist : float = 100
@export var vision_angle : float = PI/3

var vision_enabled : bool = true

func _ready():
	resetVisionShape()

func disable_vision() -> void:
	vision_enabled = false
	
func enable_vision() -> void:
	vision_enabled = true

func resetVisionShape() -> void:
	var p1 : Vector2 = Vector2.ZERO
	var p2 : Vector2 = Vector2(vision_dist*cos(vision_angle/2),vision_dist*sin(vision_angle/2))
	var p3 : Vector2 = Vector2(vision_dist*cos(vision_angle/2),-vision_dist*sin(vision_angle/2))
	var visionCone : PackedVector2Array = PackedVector2Array([p1,p2,p3])
	
	$CollisionPolygon2D.polygon = visionCone
	$Polygon2D.polygon = visionCone



func _on_body_entered(body):
	print("body entered")
	if body.is_in_group(target_group):
		target_entered_vision.emit(body)
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group(target_group):
		target_exited_vision.emit()
	pass # Replace with function body.
