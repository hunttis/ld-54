extends Control

@onready var pirateTutorial = $VBoxContainer/TopTutorial/PirateTutorial
@onready var fishingShipTutorial = $VBoxContainer/HBoxContainer/FishingShipTutorial
@onready var fishTutorial = $VBoxContainer/HBoxContainer/FishTutorial
@onready var villageTutorial = $VBoxContainer/BottomTutorial/VillageTutorial
@onready var movementTutorial = $VBoxContainer/MiddleTutorial/MovementTutorial

signal tutorial_finished()

var step = 0

func _ready():
	hideAllTutorials()
	if !Global.show_tutorial:
		tutorial_finished.emit()
	else:
		hideAllTutorials()
		pirateTutorial.visible = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_next_step()

func _next_step():
	step += 1
	if Global.show_tutorial:
		if step == 1:
			hideAllTutorials()
			fishingShipTutorial.visible = true
		elif step == 2:
			hideAllTutorials()
			fishTutorial.visible = true
		elif step == 3:
			hideAllTutorials()
			villageTutorial.visible = true
		elif step == 4:
			hideAllTutorials()
			movementTutorial.visible = true
		elif step == 5:
			hideAllTutorials()
			tutorial_finished.emit()
			Global.show_tutorial = false
	

func hideAllTutorials():
		pirateTutorial.visible = false
		fishingShipTutorial.visible = false
		fishTutorial.visible = false
		villageTutorial.visible = false
		movementTutorial.visible = false
