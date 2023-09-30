extends RichTextLabel

var previousFishCount = 0


func _process(delta):
	var currentFishCount = Global.fish
	if previousFishCount != currentFishCount:
		text = "Fish: " + str(currentFishCount)
	
	previousFishCount = currentFishCount
