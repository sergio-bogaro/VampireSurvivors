extends Node

signal healthChanged

@export var DefeatScreen: PackedScene
@export var MAX_HEALTH: int = 0

var currentHealth: int

func _ready():
	currentHealth = MAX_HEALTH
	healthChanged.emit(currentHealth, MAX_HEALTH)

func TakeDamage(hitDamage: int):
	currentHealth = max(currentHealth - hitDamage, 0)
	healthChanged.emit(currentHealth, MAX_HEALTH)
	Callable(checkDeath).call_deferred()

func checkDeath():
	if currentHealth == 0:
		owner.visible = false
		GameManager.Defeat()
