extends CanvasLayer

@onready var restartButton = %RestartButton
@onready var quitButton = %QuitButton

func _ready():
	get_tree().paused = true
	restartButton.pressed.connect(onRestartButtonPressed)
	quitButton.pressed.connect(onQuitButtonPressed)

func onRestartButtonPressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
	get_tree().paused = false
	queue_free()

func onQuitButtonPressed():
	get_tree().quit()
