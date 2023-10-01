extends "res://Assets/Scenes/Item.gd"

class_name Rock

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color.DARK_GRAY

func can_move(other: Item, items: GridItems) -> bool:
	return false
