class_name LevelData

var _level_number: int
var _row: int
var _cols: int

func _init(level_number: int, row: int, cols: int) -> void:
	_level_number = level_number
	_row = row
	_cols = cols

func get_level_number() -> int:
	return _level_number

func get_row() -> int:
	return _row

func get_cols() -> int:
	return _cols

func get_num_tiles() -> int:
	return _row * _cols

func get_target_pairs() -> int:
	return int(get_num_tiles() / 2)
