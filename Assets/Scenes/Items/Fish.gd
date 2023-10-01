extends "res://Assets/Scenes/Item.gd"

class_name Fish

func _ready():
	self.modulate = Color.DARK_BLUE

func finished_moving():
	destroy()

func on_collide(other: Item):
	if is_instance_of(other, FishingShip):
		Global.collect_fish(2)
		self.destroy()

