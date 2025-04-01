extends Node2D

var _platform_prefab: PackedScene
var _spots = [Node2D]
var _next_position: Vector2

@export var _diff_position_in_pixels: Vector2


func _ready() -> void:
	_platform_prefab = preload("res://Prefabs/Platforms/platform_spring_0.tscn")
	_next_position = Vector2()
	spawn_plataform()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_home"): spawn_plataform()

func spawn_plataform() -> void:
	var platform_instance: Node2D = _platform_prefab.instantiate()
	platform_instance.position = _next_position
	add_child(platform_instance)
	calc_next_position()

func calc_next_position() -> void:
	_next_position += _diff_position_in_pixels
