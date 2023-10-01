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

#func can_move(i: int, row: Array) -> bool:
#	if i == row.size() - 2:
#		state = State.Immobile
#
#	if state == State.Immobile:
#		health -= 1
#
#	var right: Item = row[i + 1] if i < row.size() - 1 else null
#	return state != State.Immobile and right == null
