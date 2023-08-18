extends Node
class_name Experience_Manager

signal experience_updated(playerExperience: int, targetExperience: int)
signal level_up(newLevel: int)

var experinceProgression: int = 5
var targetExperience: int = 10
var playerExperience: int = 0
var currentLevel: int = 1

func _ready():
	GameManager.experienceCollected.connect(ExperienceCollected)

func increasePlayerExperience(experienceCollected: int):
	playerExperience = min(playerExperience + experienceCollected, targetExperience)
	if playerExperience == targetExperience:
		currentLevel += 1
		targetExperience += experinceProgression
		playerExperience = 0
		level_up.emit(currentLevel)
	
	
	experience_updated.emit(playerExperience, targetExperience)
	

func ExperienceCollected(expValue):
	increasePlayerExperience(expValue)
