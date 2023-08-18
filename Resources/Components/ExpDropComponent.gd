extends Node

@export var HealthManager: HealthComponent 
@export var ExpDropList: Array[PackedScene] = []

var entitiesLayer: Node2D

func _ready():
	HealthManager.dead.connect(ExpDropHandler)

func ExpDropHandler():
	if ExpDropList.size() == 0:
		return
	
	for expDrop in ExpDropList:
		var spawnPosition = (owner as Node2D).global_position
		var expDropInstance = expDrop.instantiate() as Node2D
		entitiesLayer = get_tree().get_first_node_in_group("EntitiesLayer")
		entitiesLayer.add_child(expDropInstance)
		expDropInstance.global_position = spawnPosition
