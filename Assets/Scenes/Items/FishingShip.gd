extends "res://Assets/Scenes/Item.gd"

class_name FishingShip

var _health = 2

var _hit_color = Color(0.9, 0.3, 0.0)

func on_collide(other: Item):
	if is_instance_of(other, Fish):
		Global.collect_points(Global.POINTS__FISH_COLLECTION)
		Global.collect_fish(2)
		other.destroy()
	if is_instance_of(other, PirateShip):
		Global.collect_points(Global.POINTS__FISHING_SHIP_DESTROY)
		_health -= 1
		self.modulate = _hit_color
		other.destroy()
		if _health <= 0:
			self.destroy()
	if is_instance_of(other, Whirlpool):
		Global.collect_points(Global.POINTS__FISHING_SHIP_COLLISION_WITH_A_WHIRLPOOL)
		self.destroy()

func can_move(other: Item, items: GridItems) -> bool:
	return true
