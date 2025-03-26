extends CharacterBody2D

## -----------------------------------------------
# 		BASE STATS PLAYER
## -----------------------------------------------
const SPEED = 100.0 # 1 m/s
const JUMP_VELOCITY = -300.0 #3 m/s
const JUMP_HALF_VELOCITY = JUMP_VELOCITY * 0.5
const ACCELERATION = 600.0
const FRICTION = 1000.0

## Animations
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
	
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	jump()
	move(delta)
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

func move( delta: float) -> void:
	var input_axis: float = Input.get_axis("left", "right")
	if input_axis:
		apply_acceleration(input_axis, delta)
	else: 
		apply_friction(delta)
		
	animated_sprite.flip_h = input_axis < 0

func apply_acceleration(input_axis: float, delta: float) -> void:
	velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
		
func apply_friction(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
func animation() -> void:
	if is_on_floor():
		animated_sprite.play("Player_Idle")
	else:
		animated_sprite.play("Player_Jump")
	
