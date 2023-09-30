extends Object

class_name GridItems

var _items: Array[Item] = []

var width := 0

func _to_index(x: int, y: int) -> int:
	return y * width * x

func init(width: int, height: int) -> void:
	_items.resize(width * height)
	_items.fill(null)
	self.width = width

func get_at(x: int, y: int) -> Item:
	return _items[_to_index(x, y)]

func get_idx(i) -> Item:
	return _items[i]

func set_at(x: int, y: int, item: Item) -> Item:
	var i = _to_index(x, y)
	var previous = _items[i]
	_items[i] = item
	return previous

func swap(from: Vector2i, to: Vector2i):
	var tmp = get_at(to.x, to.y)
	set_at(to.x, to.y, get_at(from.x, from.y))
	set_at(from.x, from.y, tmp)

func row(row_index: int) -> Array[Item]:
	var start = _to_index(0, row_index)
	return range(start, start + width).map(get_idx)

func column(column_index: int) -> Array[Item]:
	var start = _to_index(column_index, 0)
	return range(start, _items.size(), width).map(get_idx)
