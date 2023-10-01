extends "res://Assets/Scenes/Item.gd"

class_name FishingShip

func _ready():
	self.modulate = Color.AQUA

#func can_move(i: int, row: Array) -> bool:
#	if i == row.size() - 2:
#		state = State.Immobile
#
#	if state == State.Immobile:
#		health -= 1
#
#	var right: Item = row[i + 1] if i < row.size() - 1 else null
#	return state != State.Immobile and right == null

func on_produce():
	print("Fishing ship producing fish!")
	Global.collect_fish(2)

func on_collide(other: Item):
	if is_instance_of(other, Fish):
		Global.collect_fish(2)
		other.destroy()
	if is_instance_of(other, PirateShip):
		other.destroy()
		self.destroy()

func can_move(other: Item, items: GridItems) -> bool:
	if is_instance_of(other, Fish) || other == null:
		return true
	return false
