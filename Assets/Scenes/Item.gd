extends AnimatedSprite2D

class_name Item


enum State {
	Movable,
	Immobile,
}

@export var state: State = State.Movable


# Called when the node enters the scene tree for the first time.
func _ready():
	if state == State.Movable:
		self.modulate = Color.GREEN
	if state == State.Immobile:
		self.modulate = Color.GRAY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func can_move(left: Item, right: Item) -> bool:
	return state != State.Immobile and (right == null or right.state != State.Immobile)
