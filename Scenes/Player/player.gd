extends CharacterBody2D

@export var MAX_SPEED: int
@export var ACELLERATION: int
@export var FRICTION: int

var speed: Vector2 = Vector2.ZERO

func _process( delta):
	var moveVector: Vector2 = GetMovementVector()
	var targetVelocity: Vector2 = moveVector * MAX_SPEED
	velocity = velocity.lerp(targetVelocity, 1 - exp(-delta * ACELLERATION))
	move_and_slide()

func GetMovementVector():
	var inputVector:Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	) 
	
	return inputVector.normalized()
