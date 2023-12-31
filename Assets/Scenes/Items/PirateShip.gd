extends "res://Assets/Scenes/Item.gd"

class_name PirateShip
@onready var soundEngine = $/root/Main/SoundEngine

func exited_grid():
	Global.village_attacked(1)
	destroy()

func can_move(other: Item, items: GridItems) -> bool:
	return true

func on_collide(other: Item):
	if is_instance_of(other, FishingShip):
		Global.collect_points(Global.POINTS__FISHING_SHIP_DESTROY)
		other.destroy()
		soundEngine.play_arrrrr()
	if is_instance_of(other, Fish):
		other.destroy()
	if is_instance_of(other, Whirlpool):
		Global.collect_points(Global.POINTS__PIRATE_SHIP_DESTROY)
		other.destroy()
		self.destroy()
