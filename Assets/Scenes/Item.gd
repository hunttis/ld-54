extends Node2D

class_name Item

signal destroyed(item: Item)

enum State {
	Movable,
	Immobile,
}

@export var state: State = State.Movable
@export var health: int = 1000
var MAX_SPEED = 10
var MIN_MOVEMENT_THRESHOLD = 10
var target: Vector2 = Vector2.ZERO
var grid_loc: Vector2i = Vector2i.ZERO

func _ready():
	pass

func _process(delta: float) -> void:
	if position.is_equal_approx(target):
		return

	var distance: Vector2 = target - position
	if distance.length() > MIN_MOVEMENT_THRESHOLD:
		var movementSpeed = distance.normalized() * MAX_SPEED
		position += movementSpeed
	else:
		position = target

func move_to(to: Vector2) -> void:
	self.target = to

func can_move(other: Item, items: GridItems) -> bool:
	return other == null

func on_collide(other: Item):
	pass

func destroy():
	destroyed.emit(self)

func exited_grid():
	pass
