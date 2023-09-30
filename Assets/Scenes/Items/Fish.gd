extends "res://Assets/Scenes/Item.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color.DARK_BLUE

func on_collect():
	print("Fish was collected")
	Global.collect_fish(1)
	health = 0
