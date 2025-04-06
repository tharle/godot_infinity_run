class_name PlatformSpawner
extends Singleton2D

var _platform_prefab: PackedScene
var _next_position: Vector2

@export var _diff_position_in_pixels: Vector2

var _platform_buffer: Array
@export var max_buffer: int = 4


func _ready() -> void:
	_platform_prefab = preload("res://Prefabs/Platforms/platform_spring_0.tscn")
	_next_position = Vector2()
	
	for i in 3:  spawn_plataform()

func spawn_plataform() -> void:
	var platform_instance: Node2D = _instantiate_platform()
	
	add_child(platform_instance)
	_add_and_remove_platform(platform_instance)
	_get_next_position(platform_instance)
	
func _instantiate_platform() -> Node2D:
	#TODO Get Random Platform
	#TODO Get Platform from correct season
	
	var platform_instance: Node2D = _platform_prefab.instantiate()
	platform_instance.position.x = _next_position.x
	
	return platform_instance

func _add_and_remove_platform(platform_instance: Node2D) -> void:
	
	#remove from platform spawner
	if _platform_buffer.size() >= max_buffer:
		var platform_oldest: Node2D = _platform_buffer.pop_front()
		remove_child(platform_oldest)
		print("Removing old node: "+platform_oldest.name)
		platform_oldest.free()
	
	_platform_buffer.push_back(platform_instance)
	
func _get_next_position(platform_instance: Node2D):
	var node_end: Node2D = platform_instance.get_node_or_null("End")
	if node_end == null:
		print("ERROR, NOT START NOT FIND IN \""+platform_instance.name+"\""  )
		return
	_next_position = node_end.global_position
	
