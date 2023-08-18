extends ProgressBar

@export var playerHealth: Node

func _ready():
	playerHealth.healthChanged.connect(onHealthChanged)

func onHealthChanged(currentHealth: float, maxHealth: float):
	var percent = currentHealth / maxHealth
	self.value = percent
