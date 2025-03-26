extends CharacterBody2D

## -----------------------------------------------
# 		BASE STATS PLAYER
## -----------------------------------------------
const SPEED : float = 100.0 # 1 m/s
const JUMP_VELOCITY : float = -300.0 #3 m/s
const JUMP_HALF_VELOCITY : float = JUMP_VELOCITY * 0.5

var double_jump_available: bool = true # control the double jump

## Animations
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer


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
	if is_on_floor() or double_jump_available:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			
			if not is_on_floor() and double_jump_available :
				double_jump_available = false
	else:
		if Input.is_action_just_released("jump") and velocity.y < JUMP_HALF_VELOCITY:
			velocity.y = JUMP_HALF_VELOCITY
	
	if velocity.y == 0:
		double_jump_available = true

func move() -> void:
	velocity.x = SPEED
	
func animation() -> void:
	if is_on_floor():
		animation_player.play("Player_Idle")
	elif double_jump_available:
		animation_player.play("Player_Jump")
	else:
		animation_player.play("Player_Jump_Double")
	
