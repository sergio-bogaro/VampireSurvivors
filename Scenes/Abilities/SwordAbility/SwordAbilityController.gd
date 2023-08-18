extends Node

@export var SwordAbility: PackedScene
@export var AbilityCD: float
@export var Player: CharacterBody2D

@onready var AbilityTimerNode: Timer = $AbilityTimer
@onready var abilityRangeNode: Area2D = $AbilityRange

var targetEnemy: CharacterBody2D
var foregroundLayer: Node2D
var damage: float = 5

func _ready():
	foregroundLayer = get_tree().get_first_node_in_group("ForegroundLayer")
	AbilityTimerNode.timeout.connect(AbilityTimeout)
	AbilityTimerNode.wait_time = AbilityCD
	GameManager.abilitiesUpdated.connect(onAbilityUpdated)

func AbilityTimeout():
	var enemiesInRange = abilityRangeNode.get_overlapping_bodies()
	if enemiesInRange.size() == 0:
		return
	
	enemiesInRange.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(Player.global_position)
		var b_distance = b.global_position.distance_squared_to(Player.global_position)
		return a_distance < b_distance
	)
	
	var swordInstance = SwordAbility.instantiate() as Sword_Ability
	foregroundLayer.add_child(swordInstance)
	swordInstance.hitBox.damage = damage
	targetEnemy = enemiesInRange[0]
	swordInstance.global_position = targetEnemy.global_position
	swordInstance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemyDirection = targetEnemy.global_position - swordInstance.global_position
	swordInstance.rotation = enemyDirection.angle()

func SetAbilityCD(value):
	AbilityCD = value
	AbilityTimerNode.wait_time = AbilityCD

func onAbilityUpdated(upgrade: AbilityUpgrade, currentUpgrades: Dictionary):
	#Adicionando mais mudancas na abilidade precisar refatorar
	if upgrade.id != "sword_rate": return
	
	SetAttackSpeed(currentUpgrades)

func SetAttackSpeed(currentUpgrades:Dictionary):
	var percentReduction = currentUpgrades["sword_rate"]["quantity"] * .1
	AbilityTimerNode.wait_time = AbilityCD * (1 - percentReduction)
	AbilityTimerNode.start()
