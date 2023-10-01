extends "res://Assets/Scenes/Floating.gd"

class_name PirateShip


func finished_moving():
	Global.village_attacked(1)
	destroy()

func can_move(other: Item, items: GridItems) -> bool:
	return true


func on_collide(other: Item):
	if is_instance_of(other, FishingShip):
		Global.collect_points(Global.POINTS__FISHING_SHIP_DESTROY)
		other.destroy()
	if is_instance_of(other, Fish):
		other.destroy()
	if is_instance_of(other, Rock):
		Global.collect_points(Global.POINTS__PIRATE_SHIP_DESTROY)
		other.destroy()
		self.destroy()
