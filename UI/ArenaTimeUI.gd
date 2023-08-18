extends CanvasLayer

@export var TimeManager: Node 
@onready var TimePassedLabel: Label = $MarginContainer/TimePassedLabel

var timePassed: int = 0
var timePassedText: String

func _process(delta):
	if !TimeManager:
		return
	
	timePassedText = formatTimePassed()
	TimePassedLabel.text = timePassedText

func formatTimePassed():
	timePassed = TimeManager.getTimePassed()
	
	var minutes: int = floor(timePassed / 60)
	var seconds: int = timePassed - (minutes * 60)
	
	var formatedMinutes: String = ("%02d" % minutes)
	var formatedSeconds: String = ("%02d" % floor(seconds))
	
	return((formatedMinutes + ":" + formatedSeconds))
