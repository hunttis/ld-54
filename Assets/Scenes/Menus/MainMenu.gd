extends Node2D

@onready var main_node = $/root/Main

func _on_start_game_button_pressed():
	main_node.change_screen(Global.Screens.PLAY_MODE)
