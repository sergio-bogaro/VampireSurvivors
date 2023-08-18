extends CanvasLayer

signal upgradeSelected

@export var UpgradeCardScene: PackedScene

@onready var CardContainerNode: HBoxContainer = $MarginContainer/CardContainer

func _ready():
	get_tree().paused = true

func SetAbilitiesUpgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var cardInstance = UpgradeCardScene.instantiate()
		CardContainerNode.add_child(cardInstance)
		cardInstance.SetAbilityUpgrade(upgrade)
		cardInstance.cardSellected.connect(onAbilitySelected.bind(upgrade))

func onAbilitySelected(upgrade : AbilityUpgrade):
	upgradeSelected.emit(upgrade)
	get_tree().paused = false
	queue_free()
