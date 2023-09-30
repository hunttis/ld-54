extends "res://Assets/Scenes/Item.gd"

func _ready():
	self.modulate = Color.CRIMSON

func can_move(i: int, row: Array) -> bool:
	if i == row.size() - 2:
		state = State.Immobile

	var right: Item = row[i + 1] if i < row.size() - 1 else null
	return state != State.Immobile and (right == null or right.state != State.Immobile)
