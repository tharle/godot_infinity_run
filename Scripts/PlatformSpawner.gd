extends Node2D

var _platform_prefab: PackedScene
var _next_position: Vector2

@export var _diff_position_in_pixels: Vector2

#TODO create a stak of platform  with 3 (erease before reuse one)


func _ready() -> void:
	_platform_prefab = preload("res://Prefabs/Platforms/platform_spring_0.tscn")
	_next_position = Vector2()
	spawn_plataform()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_home"): spawn_plataform()

func spawn_plataform() -> void:
	var platform_instance: Node2D = _platform_prefab.instantiate()
	platform_instance.position.x = _next_position.x
	add_child(platform_instance)
	
	var node_end: Node2D = platform_instance.get_node_or_null("End")
	if node_end == null:
		print("ERROR, NOT START NOT FIND IN \""+platform_instance.name+"\""  )
		return
	_next_position = node_end.global_position
