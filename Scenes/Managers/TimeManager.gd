extends Node

signal game_difficult_increased(gameDifficult : int)

const DIFICULT_INTERVAL : int = 5

@onready var GameTimer: Timer = $Timer

var gameDifficult: int = 0

func _process(delta):
	var nextTimeTarged = GameTimer.wait_time - ((gameDifficult + 1) * DIFICULT_INTERVAL)
	if GameTimer.time_left <= nextTimeTarged:
		gameDifficult += 1
		game_difficult_increased.emit(gameDifficult)

func _ready():
	GameTimer.timeout.connect(onGameTimerTimeout)

func getTimePassed():
	return GameTimer.wait_time - GameTimer.time_left

func onGameTimerTimeout():
	GameManager.Victory()
