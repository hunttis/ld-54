extends Node2D


@onready var gameover_scene = preload("res://Assets/Scenes/Menus/GameOver.tscn")
@onready var mainmenu_scene = preload("res://Assets/Scenes/Menus/MainMenu.tscn")
@onready var playmode_scene = preload("res://Assets/Scenes/PlayMode.tscn")

@onready var current_screen = $CurrentScreen

var gameover_screen
var mainmenu_screen
var playmode_screen

@export var default_screen: Global.Screens = Global.Screens.PLAY_MODE

func _ready():
	change_screen(default_screen)

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_up"):
#		change_screen(Global.Screens.PLAY_MODE)
#	elif event.is_action_pressed("ui_right"):
#		change_screen(Global.Screens.GAME_OVER)
#	elif event.is_action_pressed("ui_down"):
#		change_screen(Global.Screens.MAIN_MENU)
#	elif event.is_action_pressed("ui_left"):

func change_screen(target_screen: Global.Screens):

	if current_screen.get_child(0):
		current_screen.remove_child(current_screen.get_child(0))

	if target_screen == Global.Screens.MAIN_MENU:
		mainmenu_screen = mainmenu_scene.instantiate()
		current_screen.add_child(mainmenu_screen)
	elif target_screen == Global.Screens.PLAY_MODE:
		playmode_screen = playmode_scene.instantiate()
		current_screen.add_child(playmode_screen)
	elif target_screen == Global.Screens.GAME_OVER:
		gameover_screen = gameover_scene.instantiate()
		current_screen.add_child(gameover_screen)
