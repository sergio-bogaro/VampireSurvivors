extends Node

@export var enemyList: PackedScene

const SPAWN_RADIUS = 330

var player : CharacterBody2D
var entitiesLayer: Node2D

func _ready():
	GetData()
	$Timer.timeout.connect(SpawnTimerTimeout)

func SpawnTimerTimeout():
	if !player or !entitiesLayer:
		GetData()
		return
	
	var randonDirection = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawnPosition = player.global_position + (SPAWN_RADIUS * randonDirection)
	
	var enemy = enemyList.instantiate() as Node2D
	entitiesLayer.add_child(enemy)
	enemy.global_position = spawnPosition

func GetData():
	player = get_tree().get_first_node_in_group("Player")
	if !player:
		return
	
	entitiesLayer = get_tree().get_first_node_in_group("EntitiesLayer")
