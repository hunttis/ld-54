extends Node

var rows = 6
var columns = 6
var cell_size = 128

var fish: int = 0
var hunger: int = 0


func _ready():
	pass

func collect_fish(amount: int):
	fish += amount
