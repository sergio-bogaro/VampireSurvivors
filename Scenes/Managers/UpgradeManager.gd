extends Node

@export var upgradePool: Array[AbilityUpgrade]
@export var experienceManager: Experience_Manager
@export var upgradeScreenScene: PackedScene

var currentUpgrades = {}

func _ready():
	experienceManager.level_up.connect(onLevelUp)

func onLevelUp(currentLevel: int):
	var chosenUpgrade = upgradePool.pick_random() as AbilityUpgrade
	if !chosenUpgrade: return
	
	var upgradeScreenInstance = upgradeScreenScene.instantiate()
	add_child(upgradeScreenInstance)
	upgradeScreenInstance.SetAbilitiesUpgrades([chosenUpgrade] as Array[AbilityUpgrade])
	upgradeScreenInstance.upgradeSelected.connect(onUpgradeSelected)

func ApplyUpgrade(upgrade: AbilityUpgrade):
	var hasUpgrade = currentUpgrades.has(upgrade.id)
	if !hasUpgrade:
		currentUpgrades[upgrade.id] = {
			"resource" : upgrade,
			"quantity" : 1
		}
	else:
		currentUpgrades[upgrade.id]["quantity"] += 1
	
	GameManager.EmitAbilityUpdated(upgrade, currentUpgrades)

func onUpgradeSelected(upgrade: AbilityUpgrade):
	ApplyUpgrade(upgrade)
