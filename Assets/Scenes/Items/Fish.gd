extends "res://Assets/Scenes/Floating.gd"

class_name Fish

func finished_moving():
	destroy()

func on_collide(other: Item):
	if is_instance_of(other, FishingShip):
		Global.collect_points(Global.POINTS__FISH_COLLECTION)
		Global.collect_fish(2)
		self.destroy()
