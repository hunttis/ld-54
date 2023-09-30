extends Node2D

@onready var item_scene = preload("res://Assets/Scenes/Item.tscn")
@onready var fishing_ship_scene = preload("res://Assets/Scenes/Items/FishingShip.tscn")
@onready var fish_scene = preload("res://Assets/Scenes/Items/Fish.tscn")
@onready var pirate_scene = preload("res://Assets/Scenes/Items/PirateShip.tscn")
@onready var items_node = $Items


@export var rows = 6
@export var columns = 6
@export var cell_size = 128

var createCooldownMAX = 2
var createCooldown = 2
var oceanCurrentDirection := Vector2i.ZERO

@onready var items := GridItems.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items.init(rows, columns)

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
		if event.keycode == KEY_UP:
			oceanCurrentDirection = Vector2i.UP
			advance()
		if event.keycode == KEY_RIGHT:
			oceanCurrentDirection = Vector2i.RIGHT
			advance()
		if event.keycode == KEY_DOWN:
			oceanCurrentDirection = Vector2i.DOWN
			advance()
		if event.keycode == KEY_LEFT:
			oceanCurrentDirection = Vector2i.LEFT
			advance()
		

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
	items.set_at(row, column, item)
	return item

func place_typed_item_grid(row: int, column: int, item: Item) -> Item:
	var item_x = cell_size * column + cell_size / 2
	var item_y = cell_size * row + cell_size / 2
	# TODO: grid gap size
	item.position.x = item_x
	item.position.y = item_y
	items_node.add_child(item)
	items.set_at(row, column, item)
	item.destroyed.connect(_on_item_destroyed)
	return item

func _on_item_destroyed(item: Item):
	pass

func advance() -> void:
	print("advance")
	for col in items.columns:
		for item in items.column(col):
			if item is Fish:
				print("Fish")
				move_item(item, Vector2i.LEFT)

	for row in items.rows:
		for item in items.row(row):
			if item is PirateShip:
				print("PirateShip")
				move_item(item, Vector2i.DOWN)

	for item in items.items:
		if item:
			print("item", item)
		if item is FishingShip:
			print("Moving fishing ship to", oceanCurrentDirection)
			move_item(item, oceanCurrentDirection)
		

#	for row in range(0, rows):
#		collect_row(row)
#
#	for row in range(0, rows):
#		produce_row(row)
#
#	for row in range(0, rows):
#		cleanup_row(row)
		
	create_items()

	
func move_item(item: Item, direction: Vector2i) -> void:
	var to := item.grid_loc + direction
	if items.contains(to):
		var other = items.get_at(to.x, to.y)
		if item.can_move(other, items):
			item.position += Vector2(direction * cell_size)
			if other != null:
				item.on_collide(other)
			items.swap(item.grid_loc, to)

func create_items() -> void:
	createCooldown -= 1
	if createCooldown <= 0:
		createCooldown = createCooldownMAX
		var allRows = [0, 1, 2, 3, 4, 5]
		var randomRows = []
		var firstIndex = randi_range(0, allRows.size()-1)
		randomRows.push_back(allRows[firstIndex])
		allRows.remove_at(firstIndex)
		var secondIndex = randi_range(0, allRows.size()-1)
		randomRows.push_back(allRows[secondIndex])
		allRows.remove_at(secondIndex)
		var thirdIndex = randi_range(0, allRows.size()-1)
		randomRows.push_back(allRows[thirdIndex])
		allRows.remove_at(thirdIndex)
		print("Random rows: ", randomRows)
		
		for i in range(0, randomRows.size()):
			var new_item
			
			if i == 0:
				new_item = fishing_ship_scene.instantiate()
			elif i == 1:
				new_item = fish_scene.instantiate()
			elif i == 2:
				new_item = pirate_scene.instantiate()
			
			place_typed_item_grid(randomRows[i], 0, new_item)
				
