class_name Scorer extends Node

@onready var reveal_timer: Timer = $RevealTimer
@onready var sound: AudioStreamPlayer = $Sound

var _selections: Array[MemoryTile] = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

func _ready() -> void:
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)


func get_moves_made_str() -> String:
	return str(_moves_made)
	

func get_pairs_made_str() -> String:
	return "%d/%d" % [ _pairs_made, _target_pairs ]


func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0
	
	
func kill_tiles() -> void:
	for tile in _selections:
		tile.kill_on_succes()
		
	_pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)
	
	
func are_selections_pair() -> bool:
	if _selections.size() > 0:
		return _selections[0].maches_other_tile(_selections[1])
	return false

func is_game_over() -> bool:
	return _pairs_made == _target_pairs

func check_pair_made() -> void:
	if _selections.size() != 2:
		return
		
	reveal_timer.start()
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1
	
	if are_selections_pair():
		kill_tiles()


func check_game_over() -> void:
	if is_game_over():
		SignalManager.on_game_over.emit(_moves_made)

func on_tile_selected(memory_tile: MemoryTile) -> void:
	memory_tile.reveal(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_SELECT_TILE)
	_selections.append(memory_tile)
	check_pair_made()


func on_game_exit_pressed() -> void:
	reveal_timer.stop()

func _on_reveal_timer_timeout() -> void:
	if are_selections_pair() == false:
		for tile in _selections:
			tile.reveal(false)
	_selections.clear()
	
	check_game_over()	
	
	SignalManager.on_selection_enabled.emit()
