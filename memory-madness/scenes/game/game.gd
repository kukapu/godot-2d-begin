extends Control

const MEMORY_TILE = preload("res://scenes/memory_tile/memory_tile.tscn")

@onready var tiles_container: GridContainer = $HB/MCGame/TilesContainer
@onready var scorer: Scorer = $Scorer
@onready var label_moves: Label = $HB/MCScore/VB/HBMoves/LabelMoves
@onready var label_pairs: Label = $HB/MCScore/VB/HBPairs/LabelPairs
@onready var sound: AudioStreamPlayer = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_level_selected.connect(on_level_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_moves.text = scorer.get_moves_made_str()
	label_pairs.text = scorer.get_pairs_made_str()


func add_memory_tile(image: ItemImage, frame: Texture2D) -> void:
	var memory_tile: MemoryTile = MEMORY_TILE.instantiate()
	tiles_container.add_child(memory_tile)
	memory_tile.setup(image, frame)

func on_level_selected(level_number: int) -> void:
	var level_data: SelectedLevelData = GameManager.get_level_selection(level_number)
	var frame: Texture2D = ImageManager.get_random_frame_image()
	
	tiles_container.columns = level_data.get_num_cols()
	
	for image in level_data.get_selected_level_images():
		add_memory_tile(image, frame)
		
	scorer.clear_new_game(level_data.get_target_pairs())


#func _on_exit_button_pressed() -> void:
#	SignalManager.on_game_exit_pressed.emit()
	
func on_game_exit_pressed() -> void:
	for tile in tiles_container.get_children():
		tile.queue_free()
	SoundManager.play_button_click(sound)
