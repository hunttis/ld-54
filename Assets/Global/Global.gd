extends Node

var fish: int = 0
var hunger: int = 0

func _ready():
	pass

func collect_fish(amount: int):
	fish += amount
