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
	var index_of_item = items.find(item)
	if index_of_item > 0:
		items[index_of_item] = null

func random_empty_points(max_count: int) -> Array[Vector2i]:
	var points = _points.duplicate()
	points.shuffle()
	var result = []
	for point in points:
		var item = get_at(point.x, point.y)
		if not item:
			result.push(point)
		if result.size() >= max_count:
			return result
	return result
