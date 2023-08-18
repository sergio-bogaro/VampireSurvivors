extends Node2D

@export var XP_VALUE: int = 0

@onready var DetecionArea: Area2D = $DetectionArea

func _ready():
	DetecionArea.area_entered.connect(experienceCollected)

func experienceCollected(Area: Area2D):
	GameManager.EmitExperienceCollected(XP_VALUE)
	queue_free()
