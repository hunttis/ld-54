extends AnimatedSprite2D

class_name Item


enum State {
	Movable,
	Immobile,
}

@export var state: State = State.Movable
@export var health: int = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	if state == State.Movable:
		self.modulate = Color.GREEN
	if state == State.Immobile:
		self.modulate = Color.GRAY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func can_move(i: int, row: Array) -> bool:
	var right: Item = row[i + 1] if i < row.size() - 1 else null
	return state != State.Immobile and right == null

func on_produce():
	pass

func on_collect():
	pass
