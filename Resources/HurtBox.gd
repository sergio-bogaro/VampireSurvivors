extends Area2D
class_name HurtBox

@export var healthComponent: Node

func _ready():
	self.connect('area_entered', AreaEntered)

func AreaEntered(Area: Area2D):
	if not Area is Hit_Box or !healthComponent:
		return
	
	healthComponent.TakeDamage(Area.damage)
