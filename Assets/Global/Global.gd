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
var POINTS__FISHING_SHIP_COLLISION_WITH_A_WHIRLPOOL = -10

var game_in_progress = true
var game_over_reason = ""

var show_tutorial = true

enum Screens {
	MAIN_MENU,
	GAME_OVER,
	PLAY_MODE
}

func _ready():
	pass

func reset_stats():
	fish = 0
	hunger = 0
	village_health = 5
	score = 0

func collect_fish(amount: int):
	fish += amount

func collect_points(amount: int):
	score += amount

func village_attacked(amount: int):
	village_health -= amount
	print("Remaining village health: ", village_health)
	
	if village_health <= 0:
		show_game_over_screen("Village has run out of health points!")
	
func show_game_over_screen(reason: String):
	game_in_progress = false
	game_over_reason = reason
	print("Game over! Final score: ", score, " and fish collected: ", fish)
	main_node.change_screen(Screens.GAME_OVER)
