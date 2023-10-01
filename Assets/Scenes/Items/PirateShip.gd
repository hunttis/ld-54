extends "res://Assets/Scenes/Item.gd"

class_name PirateShip

func _ready():
	self.modulate = Color.CRIMSON

func finished_moving():
	Global.village_attacked(1)
	destroy()

func on_collide(other: Item):
	if is_instance_of(other, FishingShip):
		other.destroy()
