extends Node2D

signal startChase(node: Node2D)

signal endChase

func _ready():
	await get_tree().create_timer(4.0).timeout
	startChase.emit(self)
	await get_tree().create_timer(4.0).timeout
	endChase.emit()
