
extends RichTextLabel

var previousHunger = 0


func _process(delta):
	var currentHunger = Global.hunger
	if previousHunger != currentHunger:
		text = "Hunger: " + str(currentHunger)
	
	previousHunger = currentHunger
