extends Node2D

@onready var item_scene = preload("res://Assets/Scenes/Item.tscn")
@onready var fishing_ship_scene = preload("res://Assets/Scenes/Items/FishingShip.tscn")
@onready var fish_scene = preload("res://Assets/Scenes/Items/Fish.tscn")
@onready var pirate_scene = preload("res://Assets/Scenes/Items/PirateShip.tscn")
@onready var items_node = $Items

@export var rows = 5
@export var columns = 5
@export var cell_size = 128

var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, rows):
		var row = []
		for c in range(0, columns + 1):
			row.push_back(null)
		items.push_back(row)
		
	var item1 = place_item_grid(0, 0, Item.State.Movable)
	var item2 = place_item_grid(0, 2, Item.State.Immobile)
	var item3 = place_item_grid(0, 3, Item.State.Movable)
	
	
	var fishing_ship = fishing_ship_scene.instantiate()
	place_typed_item_grid(1, 0, fishing_ship)
	
	var fish = fish_scene.instantiate()
	place_typed_item_grid(2, 0, fish)
	
	var pirate_ship = pirate_scene.instantiate()
	place_typed_item_grid(3, 0, pirate_ship)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		advance()
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			place_item(0)
		if event.keycode == KEY_2:
			place_item(1)
		if event.keycode == KEY_3:
			place_item(2)
		if event.keycode == KEY_4:
			place_item(3)
		if event.keycode == KEY_5:
			place_item(4)

func place_item(row: int) -> Item:
	return place_item_grid(row, 0)
	
func place_item_grid(row: int, column: int, state = Item.State.Movable) -> Item:
	var item_x = cell_size * column + cell_size / 2
	var item_y = cell_size * row + cell_size / 2
	# TODO: grid gap size
	var item = item_scene.instantiate() as Item
	item.position.x = item_x
	item.position.y = item_y
	item.state = state
	items_node.add_child(item)
	items[row][column] = item
	return item
	
func place_typed_item_grid(row: int, column: int, item: Item) -> Item:
	var item_x = cell_size * column + cell_size / 2
	var item_y = cell_size * row + cell_size / 2
	# TODO: grid gap size
	item.position.x = item_x
	item.position.y = item_y
	items_node.add_child(item)
	items[row][column] = item
	return item

func advance() -> void:
	for row in range(0, rows):
		advance_row(row)

func advance_row(row_i: int) -> void:
	var row = items[row_i]
	for i in range(row.size() - 2, -1, -1):
		var item = row[i]
		if item != null and item.can_move(i, row as Array[Item]):
			item.position.x += cell_size
			row[i + 1] = item
			row[i] = null
