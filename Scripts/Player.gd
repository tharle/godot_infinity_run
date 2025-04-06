class_name Player
extends CharacterBody2D

## -----------------------------------------------
# 		Extern
## -----------------------------------------------
var _platform_spawner: PlatformSpawner

## -----------------------------------------------
# 		BASE STATS PLAYER
## -----------------------------------------------
const SPEED : float = 100.0 # 1 m/s
const JUMP_VELOCITY : float = -300.0 #3 m/s
const JUMP_HALF_VELOCITY : float = JUMP_VELOCITY * 0.5

var _double_jump_available: bool = true # control the double jump

## Animations
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_platform_spawner = PlatformSpawner.instance

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	jump()
	move()
	animation()
	
	move_and_slide()

func apply_gravity(delta: float)-> void:
	# Gravity is 980 by default.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func jump() ->void :
	if is_on_floor() or _double_jump_available:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			
			if not is_on_floor() and _double_jump_available :
				_double_jump_available = false
	else:
		if Input.is_action_just_released("jump") and velocity.y < JUMP_HALF_VELOCITY:
			velocity.y = JUMP_HALF_VELOCITY
	
	if velocity.y == 0:
		_double_jump_available = true

func move() -> void:
	velocity.x = SPEED
	
func animation() -> void:
	if is_on_floor():
		animation_player.play("Player_Idle")
	elif _double_jump_available:
		animation_player.play("Player_Jump")
	else:
		animation_player.play("Player_Jump_Double")
	
