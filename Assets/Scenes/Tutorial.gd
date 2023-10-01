extends Control

@onready var pirateTutorial = $VBoxContainer/TopTutorial/PirateTutorial
@onready var fishingShipTutorial = $VBoxContainer/HBoxContainer/FishingShipTutorial
@onready var fishTutorial = $VBoxContainer/HBoxContainer/FishTutorial
@onready var villageTutorial = $VBoxContainer/BottomTutorial/VillageTutorial
@onready var movementTutorial = $VBoxContainer/MiddleTutorial/MovementTutorial


var timer = 0
var howLongToShowOneTutorial = 5

func _ready():
	hideAllTutorials()

func _process(delta):
	timer += delta
	if Global.show_tutorial:
		if timer < howLongToShowOneTutorial:
			hideAllTutorials()
			pirateTutorial.visible = true
		elif timer < howLongToShowOneTutorial * 2:
			hideAllTutorials()
			fishingShipTutorial.visible = true
		elif timer < howLongToShowOneTutorial * 3:
			hideAllTutorials()
			fishTutorial.visible = true
		elif timer < howLongToShowOneTutorial * 4:
			hideAllTutorials()
			villageTutorial.visible = true
		elif timer < howLongToShowOneTutorial * 5:
			hideAllTutorials()
			movementTutorial.visible = true
		elif timer < howLongToShowOneTutorial * 6:
			hideAllTutorials()

func hideAllTutorials():
		pirateTutorial.visible = false
		fishingShipTutorial.visible = false
		fishTutorial.visible = false
		villageTutorial.visible = false
		movementTutorial.visible = false
