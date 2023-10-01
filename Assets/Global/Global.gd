extends Node

@onready var main_node = $/root/Main

var rows = 6
var columns = 6
var cell_size = 128

var fish: int = 0
var hunger: int = 0
var village_health: int = 5
var score: int = 0

var POINTS__FISH_COLLECTION = 10
var POINTS__PIRATE_SHIP_DESTROY = 30
var POINTS__FISHING_SHIP_DESTROY = -10
var POINTS__FISHING_SHIP_COLLISION_WITH_A_ROCK = -10

var game_in_progress = true

enum Screens {
	MAIN_MENU,
	GAME_OVER,
	PLAY_MODE
}

func _ready():
	pass

func collect_fish(amount: int):
	fish += amount

func collect_points(amount: int):
	print("points to add ", amount)
	score += amount

func village_attacked(amount: int):
	village_health -= amount
	print("Remaining village health: ", village_health)
	
	if village_health <= 0:
		show_game_over_screen()
	
func show_game_over_screen():
	game_in_progress = false
	print("Game over! Final score: ", score, " and fish collected: ", fish)
	main_node.change_screen(Screens.GAME_OVER)
