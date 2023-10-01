extends Node2D

@onready var grid: Grid = $Grid
@onready var soundEngine = $/root/Main/SoundEngine

enum Turn {
	Player,
	Fish,
	Enemy
}

var turn := Turn.Player

func _ready() -> void:
	grid.advance_done.connect(_on_turn_done)

func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	# print("Input. Advancing: ", advancing, ", turn: ", Turn.find_key(turn))
	if not grid.advancing and turn == Turn.Player:
		if event.is_action_pressed("ui_up"):
			_play_player_turn(Vector2i.UP)
		elif event.is_action_pressed("ui_right"):
			_play_player_turn(Vector2i.RIGHT)
		elif event.is_action_pressed("ui_down"):
			_play_player_turn(Vector2i.DOWN)
		elif event.is_action_pressed("ui_left"):
			_play_player_turn(Vector2i.LEFT)

func _play_player_turn(direction: Vector2i):
	soundEngine.play_got_fish()
	_run_turn(FishingShip, direction)

func _run_turn(item_type: Variant, direction: Vector2):
	grid.start_advance(item_type, direction)

func _on_turn_done():
	print("TURN DONE ", Turn.find_key(turn))
	if turn == Turn.Player:
		turn = Turn.Fish
		_run_turn(Fish, Vector2i.LEFT)
	elif turn == Turn.Fish:
		turn = Turn.Enemy
		_run_turn(PirateShip, Vector2i.DOWN)
	elif turn == Turn.Enemy:
		turn = Turn.Player
		grid.create_items()
