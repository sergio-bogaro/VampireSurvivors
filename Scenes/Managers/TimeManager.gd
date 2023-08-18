extends Node

@onready var GameTimer: Timer = $Timer

func _ready():
	GameTimer.timeout.connect(onGameTimerTimeout)

func getTimePassed():
	return GameTimer.wait_time - GameTimer.time_left

func onGameTimerTimeout():
	GameManager.Victory()
