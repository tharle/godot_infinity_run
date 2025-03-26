extends CharacterBody2D

## -----------------------------------------------
# 		BASE STATS PLAYER
## -----------------------------------------------
const SPEED : float = 100.0 # 1 m/s
const JUMP_VELOCITY : float = -300.0 #3 m/s
const JUMP_HALF_VELOCITY : float = JUMP_VELOCITY * 0.5

## Animations
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

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
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("jump") and velocity.y < JUMP_HALF_VELOCITY:
			velocity.y = JUMP_HALF_VELOCITY

func move() -> void:
	velocity.x = SPEED
	
func animation() -> void:
	if is_on_floor():
		animated_sprite.play("Player_Idle")
	else:
		animated_sprite.play("Player_Jump")
	
