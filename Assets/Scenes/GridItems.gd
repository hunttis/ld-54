extends Object

class_name GridItems

var items: Array[Item] = []

var _points: Array[Vector2i] = []

var columns := 0
var rows := 0

func _to_index(x: int, y: int) -> int:
	return y * columns + x

func init(columns: int, rows: int) -> void:
	items.resize(columns * rows)
	items.fill(null)
	
	_points.resize(columns * rows)
	for col in columns:
		for row in rows:
			var i = _to_index(col, row)
			_points[i] = Vector2i(col, row)
	print("Grid array size: ", items.size())
	self.columns = Global.columns
	self.rows = Global.rows

func contains(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < columns and pos.y >= 0 and pos.y < rows
	
func get_at(x: int, y: int) -> Item:
	var i = _to_index(x, y)
	if i < 0 or i >= items.size():
		return null
	return items[i]

func get_idx(i) -> Item:
	return items[i]

func set_at(x: int, y: int, item: Item) -> Item:
	var i = _to_index(x, y)
	var previous = items[i]
	items[i] = item
	if item:
		item.grid_loc = Vector2i(x, y)
	return previous

func swap(from: Vector2i, to: Vector2i):
	var tmp = get_at(to.x, to.y)
	if contains(from) && contains(to):
		set_at(to.x, to.y, get_at(from.x, from.y))
		set_at(from.x, from.y, tmp)

func row(row_index: int) -> Array[Item]:
	var start = _to_index(0, row_index)
	var result: Array[Item] = []
	for i in range(start, start + columns):
		result.push_back(get_idx(i))
	return result

func column(column_index: int) -> Array[Item]:
	var start = _to_index(column_index, 0)
	var result: Array[Item] = []
	for i in range(start, items.size(), columns):
		result.push_back(get_idx(i))
	return result

func delete(item: Item) -> void:
	var idx = items.find(item)
	while idx >= 0:
		items[idx] = null
		idx = items.find(item)

func random_empty_point_on_column(column_number: int) -> int:
	var possible_points = []
	
	for row in rows:
		if !get_at(column_number, row):
			possible_points.push_back(row)
	
	if possible_points.size() > 0:
		return possible_points.pick_random()
	else:
		return -1
		
func random_empty_point_on_row(row_number: int) -> int:
	var possible_points = []
	
	for column in columns:
		if !get_at(column, row_number):
			possible_points.push_back(column)
	
	if possible_points.size() > 0:
		return possible_points.pick_random()
	else:
		return -1
	

func random_empty_points(max_count: int) -> Array[Vector2i]:
	var points: Array[Vector2i] = []
	for point in _points:
		points.push_back(Vector2i(point))
	points.shuffle()
	var result: Array[Vector2i] = []
	for point in points:
		var item = get_at(point.x, point.y)
		if not item:
			result.push_back(point)
		if result.size() >= max_count:
			return result
	return result

func fishing_ships_count() -> int:
	var count = 0
	
	for item in items:
		if is_instance_of(item, FishingShip):
			count += 1
			
	return count
