class_name EnemySpawner
extends Singleton2D

var _height_fly: float
var _height_ground: float

var _enemy_prefab: PackedScene

var _buffer: Array
@export var max_buffer: int = 6
@export var ground_enemy: bool = true

@export var delay: float = 3.0
var _time_passed: float = 0.0

@export var to_follow: Node2D
var _diff_position: Vector2

func _ready() -> void:
	_enemy_prefab = preload("res://Prefabs/Enemy.tscn")
	_diff_position = global_position - to_follow.global_position
	
func _process(delta: float) -> void:
	_time_passed += delta
	if _time_passed >= delay :
		_time_passed -= delay
		_spawn()
	
	_follow()
	
	if Input.is_action_just_pressed("ui_text_delete"):
		_spawn()

func _follow() -> void:
	position.x = to_follow.global_position.x + _diff_position.x

func _spawn() -> void:
	var enemy_instance: Node2D = _instantiate_enemy()
	get_parent().add_child(enemy_instance)
	
	print("Enemy spawner: "+enemy_instance.name)
	_add_and_remove_enemy(enemy_instance)

func _instantiate_enemy() -> Node2D:
	#TODO Get Random Enemy (verify if ground or fly enemy)
	var enemy_instance: Node2D = _enemy_prefab.instantiate()
	
	return enemy_instance
	
func _add_and_remove_enemy(enemy_instance: Node2D) -> void:
	
	if _buffer.size() >= max_buffer:
		var enemy_oldest: Node2D = _buffer.pop_front()
		remove_child(enemy_oldest)
		print("Removing enemy: "+enemy_oldest.name)
		enemy_oldest.free()
	
	_buffer.push_back(enemy_instance)
