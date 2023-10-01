extends Node2D

@onready var main_node = $/root/Main

@onready var tutorial_button = $Control/VBoxContainer/HBoxContainer2/TutorialButton
@onready var sound_button = $Control/VBoxContainer/HBoxContainer2/SoundButton
@onready var soundEngine = $/root/Main/SoundEngine

func _ready():
	tutorial_button.text = "Tutorial: On" if Global.show_tutorial else "Tutorial: Off"
	sound_button.text = "Sounds: Off" if soundEngine.is_muted() else "Sounds: On"

func _on_start_game_button_pressed():
	main_node.change_screen(Global.Screens.PLAY_MODE)

func _on_tutorial_button_pressed():
	Global.show_tutorial = !Global.show_tutorial
	tutorial_button.text = "Tutorial: On" if Global.show_tutorial else "Tutorial: Off"

func _on_sound_button_pressed():
	sound_button.text = "Sounds: Off" if soundEngine.is_muted() else "Sounds: On"
	soundEngine.toggle_mute()
