extends Node
class_name HealthComponent

signal dead

@export var MAX_HEALTH: int = 0

var currentHealth: int

func _ready():
	currentHealth = MAX_HEALTH

func TakeDamage(hitDamage: int):
	currentHealth = max(currentHealth - hitDamage, 0)
	Callable(checkDeath).call_deferred()

func checkDeath():
	if currentHealth == 0:
		dead.emit()
		owner.queue_free()
