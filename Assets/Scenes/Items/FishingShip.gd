extends "res://Assets/Scenes/Item.gd"

class_name FishingShip
@onready var soundEngine = $/root/Main/SoundEngine

func on_collide(other: Item):
	if is_instance_of(other, Fish):
		Global.collect_points(Global.POINTS__FISH_COLLECTION)
		Global.collect_fish(2)
		other.destroy()
		soundEngine.play_got_fish()
	if is_instance_of(other, PirateShip):
		Global.collect_points(Global.POINTS__FISHING_SHIP_DESTROY)
		other.destroy()
		self.destroy()
	if is_instance_of(other, Whirlpool):
		Global.collect_points(Global.POINTS__FISHING_SHIP_COLLISION_WITH_A_WHIRLPOOL)
		self.destroy()

func can_move(other: Item, items: GridItems) -> bool:
	return true
