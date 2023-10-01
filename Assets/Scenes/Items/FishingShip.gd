extends "res://Assets/Scenes/Floating.gd"

class_name FishingShip

func on_collide(other: Item):
	if is_instance_of(other, Fish):
		Global.collect_fish(2)
		other.destroy()
	if is_instance_of(other, PirateShip):
		other.destroy()
		self.destroy()
	if is_instance_of(other, Rock):
		self.destroy()

func can_move(other: Item, items: GridItems) -> bool:
#	if is_instance_of(other, Fish) || is_instance_of(other, PirateShip) || other == null:
	return true
#	return false
