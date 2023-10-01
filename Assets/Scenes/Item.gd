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
	
	var MAX_SPEED = 10
	var MIN_MOVEMENT_THRESHOLD = 10
	var currentPosition = position
	var targetPosition = grid_loc * Global.cell_size + Vector2i(Global.cell_size / 2, Global.cell_size / 2)
	
	var distance: Vector2 = Vector2(targetPosition) - Vector2(currentPosition)
	if distance.length() > MIN_MOVEMENT_THRESHOLD:
		var movementSpeed = distance.normalized() * MAX_SPEED
		position += movementSpeed
	else:
		position = targetPosition
#	if currentPosition.x > targetPosition.x:
#		position.x -= 3
#	if currentPosition.x < targetPosition.x:
#		position.x += 3
#	if currentPosition.y > targetPosition.y:
#		position.y -= 3
#	if currentPosition.y < targetPosition.y:
#		position.y += 3
	
	
	
func can_move(other: Item, items: GridItems) -> bool:
	return other == null

func on_collide(other: Item):
	pass

func destroy():
	destroyed.emit(self)

func finished_moving():
	pass
