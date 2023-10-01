extends Node2D

class_name Grid

signal advance_done();

@onready var item_scene = preload("res://Assets/Scenes/Item.tscn")
@onready var fishing_ship_scene = preload("res://Assets/Scenes/Items/FishingShip.tscn")
@onready var fish_scene = preload("res://Assets/Scenes/Items/Fish.tscn")
@onready var pirate_scene = preload("res://Assets/Scenes/Items/PirateShip.tscn")
@onready var whirlpool_scene = preload("res://Assets/Scenes/Items/Whirlpool.tscn")
@onready var items_node = $Items

@onready var grid_cell_scene = preload("res://Assets/Scenes/grid_cell.tscn")
@onready var gridContainer = $GridControl/Container

var createFishCooldownMAX = 2
var createFishCooldown = 2

var createFishingShipCooldownMAX = 5
var createFishingShipCooldown = 5

var createPirateCooldownMAX = 2
var createPirateCooldown = 2

var createWhirlpoolCooldownMAX = 5
var createWhirlpoolCooldown = 2

var grid_gap: int = 0

var moving_items: Array[Item] = []
var advancing = false

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
		
func _process(delta: float) -> void:
	if not advancing:
		return
		
	if moving_items.is_empty():
		advance_done.emit()
		return

	for item in moving_items:
		if not is_instance_valid(item):
			continue
		if not item.position.is_equal_approx(item.target):
			return
	moving_items.clear()
	advancing = false
	advance_done.emit()

func start_advance(item_type: Variant, direction: Vector2i):
	advancing = true
	move_typed_items_to_direction(item_type, direction)

func place_typed_item_grid(column: int, row: int, item: Item) -> Item:
	var gap_offset_x = clamp(grid_gap * (column - 1), 0, grid_gap * Global.columns)
	var gap_offset_y = clamp(grid_gap * (row - 1), 0, grid_gap * Global.rows)
	var item_x = Global.cell_size * column + Global.cell_size / 2 + gap_offset_x
	var item_y = Global.cell_size * row + Global.cell_size / 2 + gap_offset_y
	var item_pos = Vector2(item_x, item_y)
	# TODO: grid gap size
	item.position = item_pos
	item.target = item_pos
	item.grid_loc = Vector2i(column, row)
	items_node.add_child(item, true)
	items.set_at(column, row, item)
	item.destroyed.connect(_on_item_destroyed)
	return item

func _on_item_destroyed(item: Item):
	items.delete(item)
	item.queue_free()
	_remove_moving(item)

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
	# There were no items to move, complete advance
	if moving_items.is_empty():
		advance_done.emit()

func move_item(item: Item, direction: Vector2i) -> void:
	var to := item.grid_loc + direction
	if item && items.contains(to):
		var other = items.get_at(to.x, to.y)
		if item.can_move(other, items):
			if other != null:
				print("item: ", item.name, " is colliding with.", other.name)
				item.on_collide(other)
			items.swap(item.grid_loc, to)
			item.move_to(to * Global.cell_size + Vector2i(Global.cell_size / 2, Global.cell_size / 2))
			moving_items.push_back(item)
	else:
		print(item.name, " exited grid!")
		item.exited_grid()

func create_items() -> void:
	createFishCooldown -= 1
	createFishingShipCooldown -= 1
	createPirateCooldown -= 1
	createWhirlpoolCooldown -= 1
	
	if createFishCooldown <= 0:
		createFishCooldown = createFishCooldownMAX
		var fish_row = items.random_empty_point_on_column(Global.columns - 1)
		if fish_row >= 0:
			var new_item = fish_scene.instantiate()
			place_typed_item_grid(Global.columns - 1, fish_row, new_item)

	if createPirateCooldown <= 0:
		createPirateCooldown = createPirateCooldownMAX
		var pirate_column = items.random_empty_point_on_row(0)
		
		if pirate_column >= 0:
			var new_item = pirate_scene.instantiate()
			place_typed_item_grid(pirate_column, 0, new_item)
		
	if createFishingShipCooldown <= 0:
		createFishingShipCooldown = createFishingShipCooldownMAX
		var fishing_row = items.random_empty_point_on_column(0)
		
		if fishing_row >= 0:
			var new_item = fishing_ship_scene.instantiate()
			place_typed_item_grid(0, fishing_row, new_item)

	if createWhirlpoolCooldown <= 0:
		createWhirlpoolCooldown = createWhirlpoolCooldownMAX
		var points = items.random_empty_points(1)
		
		if points.size() == 1:
			var new_item = whirlpool_scene.instantiate()
			place_typed_item_grid(points[0].x, points[0].y, new_item)

	if items.fishing_ships_count() == 0:
		Global.show_game_over_screen("No fishing ships left!")

func _remove_moving(item: Item):
	if moving_items.is_empty():
		return
	moving_items.erase(item)
