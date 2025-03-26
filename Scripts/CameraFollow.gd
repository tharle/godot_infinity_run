extends Camera2D

@export var target: Node2D

#const OFFSET_CAMERA: Vector2D = new(0, 0)
const OFFSET_PLAYER: float = -32.0

func _physics_process(_delta: float) -> void:
	position.x = target.position.x + offset.x + OFFSET_PLAYER
