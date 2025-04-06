class_name Singleton2D
extends Node2D

static var _instance: Singleton2D = null

static var instance: Node2D:
	get:
		return _instance

func _init() -> void:
	if instance == null:
		_instance = self
		

func _enter_tree() -> void:
	if instance == null:
		_instance = self

func _exit_tree() -> void:
	if instance == self:
		_instance = null
