extends CharacterBody2D

@export var MAX_SPEED: int
@export var DAMAGE: int
@export var healthComponent: HealthComponent
@export var hitBoxComponent: Hit_Box

var player: CharacterBody2D
var playerDirection: Vector2 = Vector2.ZERO

func _ready():
	hitBoxComponent.damage = DAMAGE

func _process(delta):
	player = get_tree().get_first_node_in_group("Player")
	if !player:
		return
	
	playerDirection = (player.global_position - global_position).normalized()
	velocity = playerDirection * MAX_SPEED
	move_and_slide()
