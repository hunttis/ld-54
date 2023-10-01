extends Node2D

@onready var main_node = $/root/Main
@onready var game_over_reason = $Control/VBoxContainer/HBoxContainer3/GameOverReason
@onready var point_label =  $Control/VBoxContainer/HBoxContainer/PointLabel
@onready var fish_label = $Control/VBoxContainer/HBoxContainer2/FishLabel

func _ready():
	game_over_reason.text = Global.game_over_reason
	point_label.text = "You got " + str(Global.score) + " points!"
	fish_label.text = "You also caught " + str(Global.fish) + " fish!"

func _on_button_pressed():
	main_node.change_screen(Global.Screens.MAIN_MENU)
