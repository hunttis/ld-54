extends Node2D

@onready var item_scene = preload("res://Assets/Scenes/Item.tscn")
@onready var fishing_ship_scene = preload("res://Assets/Scenes/Items/FishingShip.tscn")
@onready var fish_scene = preload("res://Assets/Scenes/Items/Fish.tscn")
@onready var pirate_scene = preload("res://Assets/Scenes/Items/PirateShip.tscn")
@onready var items_node = $Items

@onready var grid_cell_scene = preload("res://Assets/Scenes/grid_cell.tscn")
@onready var gridContainer = $GridControl/Container

var createCooldownMAX = 2
var createCooldown = 2
var oceanCurrentDirection := Vector2i.ZERO
var grid_gap: int = 0

@onready var items := GridItems.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items.init(Global.rows, Global.columns)
	grid_gap = gridContainer.get_theme_constant("h_separation")

	var fishing_ship = fishing_ship_scene.instantiate()
	place_typed_item_grid(1, 3, fishing_ship)
	
	var fish = fish_scene.instantiate()
	place_typed_item_grid(Global.columns - 2, 3, fish)
	
	var pirate_ship = pirate_scene.instantiate()
	place_typed_item_grid(4, 1, pirate_ship)
		
	gridContainer.columns = Global.columns
	for i in range(0, Global.columns * Global.rows):
		var cell = grid_cell_scene.instantiate()
		gridContainer.add_child(cell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		advance()
	elif event.is_action_pressed("ui_up"):
		oceanCurrentDirection = Vector2i.UP
		advance()
	elif event.is_action_pressed("ui_right"):
		oceanCurrentDirection = Vector2i.RIGHT
		advance()
	elif event.is_action_pressed("ui_down"):
		oceanCurrentDirection = Vector2i.DOWN
		advance()
	elif event.is_action_pressed("ui_left"):
		oceanCurrentDirection = Vector2i.LEFT
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
	var gap_offset_x = grid_gap * column
	var gap_offset_y = grid_gap * row
	var item_x = Global.cell_size * column + Global.cell_size / 2 + gap_offset_x
	var item_y = Global.cell_size * row + Global.cell_size / 2 + gap_offset_y
	# TODO: grid gap size
	var item = item_scene.instantiate() as Item
	item.position.x = item_x
	item.position.y = item_y
	item.state = state
	items_node.add_child(item)
	items.set_at(row, column, item)
	return item

func place_typed_item_grid(column: int, row: int, item: Item) -> Item:
	var gap_offset_x = clamp(grid_gap * (column - 1), 0, grid_gap * Global.columns)
	print("GAP: ", gap_offset_x)
	var gap_offset_y = clamp(grid_gap * (row - 1), 0, grid_gap * Global.rows)
	var item_x = Global.cell_size * column + Global.cell_size / 2 + gap_offset_x
	var item_y = Global.cell_size * row + Global.cell_size / 2 + gap_offset_y
	# TODO: grid gap size
	item.position.x = item_x
	item.position.y = item_y
	item.grid_loc = Vector2i(column, row)
	items_node.add_child(item)
	items.set_at(column, row, item)
	item.destroyed.connect(_on_item_destroyed)
	return item

func _on_item_destroyed(item: Item):
	print(item, " wants to be destroyed")
	items.delete(item)
	item.queue_free()

func advance() -> void:
	print("advance")
	
	move_typed_items_to_direction(Fish, Vector2i.LEFT)
	move_typed_items_to_direction(PirateShip, Vector2i.DOWN)
	move_typed_items_to_direction(FishingShip, oceanCurrentDirection)	
#	create_items()
	
	

func move_typed_items_to_direction(itemType: Variant, direction: Vector2i) -> void:
	if direction == Vector2i.UP:
		for row in range(0, items.rows):
			for item in items.row(row):
				if is_instance_of(item, itemType):
					move_item(item, direction)
	elif direction == Vector2i.DOWN:
		for row in range(items.rows - 1, -1, -1):
			for item in items.row(row):
				if is_instance_of(item, itemType):
					move_item(item, direction)
	elif direction == Vector2i.LEFT:
		for col in items.columns:
			for item in items.column(col):
				if is_instance_of(item, itemType):
					move_item(item, direction)
	elif direction == Vector2i.RIGHT:
		for col in range(items.columns - 1, -1, -1):
			for item in items.column(col):
				if is_instance_of(item, itemType):
					move_item(item, direction)
	
func move_item(item: Item, direction: Vector2i) -> void:
	var to := item.grid_loc + direction
	if items.contains(to):
		var other = items.get_at(to.x, to.y)
		if item.can_move(other, items):
			item.position += Vector2(direction * Global.cell_size)
			if other != null:
				print("item: ", item, " is colliding with.", other)
				item.on_collide(other)
			items.swap(item.grid_loc, to)
	else:
		print(item.name, " Finished moving!")
		item.finished_moving()

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
			
#			place_typed_item_grid(randomRows[i], 0, new_item)
				

func create_pirate_ship(column: int) -> void:
	var pirate_ship = pirate_scene.instantiate()
	
