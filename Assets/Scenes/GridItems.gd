extends Object

class_name GridItems

var items: Array[Item] = []

var columns := 0
var rows := 0

func _to_index(x: int, y: int) -> int:
	return y * columns + x

func init(columns: int, rows: int) -> void:
	items.resize(columns * rows)
	items.fill(null)
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
	
