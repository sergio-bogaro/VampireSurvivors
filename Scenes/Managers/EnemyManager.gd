extends Node

@onready var EnemyTimer: Timer = $Timer

@export var enemyList: PackedScene
@export var TimeManager : Node

const SPAWN_RADIUS = 330

var player : CharacterBody2D
var entitiesLayer: Node2D
var baseWaitTime: int = 0

func _ready():
	GetData()
	baseWaitTime = EnemyTimer.wait_time
	EnemyTimer.timeout.connect(SpawnTimerTimeout)
	TimeManager.game_difficult_increased.connect(onGameDifficultIncreased)

func SpawnTimerTimeout():
	EnemyTimer.start()
	
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

func onGameDifficultIncreased(gameDifficult : int):
	var timeOff = 0.1 / 12
	# timeOff = max(0.7, timeOff)
	EnemyTimer.wait_time = baseWaitTime - timeOff
