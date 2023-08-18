extends PanelContainer

signal cardSellected

@onready var nameLabel = $VBoxContainer/NameLabel
@onready var descriptionLabel = $VBoxContainer/DescriptionLabel

func _ready():
	gui_input.connect(onInputEvent)

func SetAbilityUpgrade(upgrade: AbilityUpgrade):
	nameLabel.text = upgrade.name
	descriptionLabel.text = upgrade.description
	
func onInputEvent(event: InputEvent):
	if event.is_action_pressed("left_click"):
		cardSellected.emit()
