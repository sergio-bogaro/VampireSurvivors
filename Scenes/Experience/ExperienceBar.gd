extends CanvasLayer

@export var experienceManager: Experience_Manager

@onready var progressBar : ProgressBar = $MarginContainer/ProgressBar

func _ready():
	experienceManager.experience_updated.connect(onExperienceUpdated)

func onExperienceUpdated(currentExperience: float, targetExperience: float):
	var percent = currentExperience / targetExperience
	progressBar.value = percent
