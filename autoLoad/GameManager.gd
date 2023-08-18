extends Node

@onready var DeafeatScreen: PackedScene = preload("res://UI/DefeatScreen.tscn")
@onready var VictoryScreen: PackedScene = preload("res://UI/VictoryScreen.tscn")

signal experienceCollected(expValue : int)
signal abilitiesUpdated(upgrade: AbilityUpgrade, currentUpgrades: Dictionary)

func Victory():
	var victoryScreenIntance = VictoryScreen.instantiate()
	add_child(victoryScreenIntance)

func Defeat():
	var defeatScreenIntance = DeafeatScreen.instantiate()
	add_child(defeatScreenIntance)

func EmitExperienceCollected(expValue : int):
	experienceCollected.emit(expValue)

func EmitAbilityUpdated(upgrade: AbilityUpgrade, currentUpgrades: Dictionary):
	abilitiesUpdated.emit(upgrade, currentUpgrades)
