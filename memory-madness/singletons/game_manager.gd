extends Node

var _levels: Dictionary = {
	1: LevelData.new(1, 2, 2),
	2: LevelData.new(2, 3, 4),
	3: LevelData.new(3, 4, 5),
	4: LevelData.new(4, 5, 6),
	5: LevelData.new(5, 6, 6),
	6: LevelData.new(6, 7, 8),
}

func get_level_data(level_number: int) -> LevelData:
	return _levels[level_number]

func get_num_levels() -> int:
	return _levels.keys().size()

func get_level_selection(level_number: int) -> SelectedLevelData:
	var level_data: LevelData = get_level_data(level_number)
	var selected_level_images: Array[ItemImage] = []
	ImageManager.shuffle_images()
	for i in range(level_data.get_target_pairs()):
		selected_level_images.append(ImageManager.get_image_by_index(i))
		selected_level_images.append(ImageManager.get_image_by_index(i))

	selected_level_images.shuffle()

	return SelectedLevelData.new(
		level_data.get_target_pairs(),
		level_data.get_cols(),
		selected_level_images
	)
