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
