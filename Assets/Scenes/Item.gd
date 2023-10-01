extends AnimatedSprite2D

class_name Item

signal destroyed(item: Item)

enum State {
	Movable,
	Immobile,
}

@export var state: State = State.Movable
@export var health: int = 1000
var grid_loc: Vector2i = Vector2i.ZERO

func _ready():
	if state == State.Movable:
		self.modulate = Color.GREEN
	if state == State.Immobile:
		self.modulate = Color.GRAY


func _process(delta):
	pass
	
func can_move(other: Item, items: GridItems) -> bool:
	return other == null

func on_collide(other: Item):
	pass

func destroy():
	destroyed.emit(self)

func finished_moving():
	pass
