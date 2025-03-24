class_name Player

extends CharacterBody2D

const dimension = {x= 16, y= 16}

@export var speed : float = 8 * dimension.x
@export var jump_speed : float = -2 * dimension.y
@export var gravity : float = 0 * dimension.y

func _physics_process(delta: float) -> void:
	# Add gravity every frame
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed(InputControls.LEFT):
		print("LEFT PRESS")
	
	#Input affects x axis only
	velocity.x = Input.get_axis(InputControls.LEFT, InputControls.RIGHT) * speed
	
	move_and_slide()
	
	#Only allow jumping when on the ground
	if Input.is_action_just_pressed(InputControls.JUMP) and is_on_floor():
		velocity.y = jump_speed
