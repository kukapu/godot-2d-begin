extends Node

var _attemps: int = 0
var _cups_hit: int = 0
var _total_cups: int = 0
var _level_number: int = 1


func _ready() -> void:
	_total_cups = get_tree().get_nodes_in_group("cup").size()
	_level_number = ScoreManager.get_level_selected()
	SignalManager.on_attempt_made.connect(on_attempt_made)
	SignalManager.on_cup_destroy.connect(on_cup_destroy)

func on_attempt_made() -> void:
	_attemps += 1
	SignalManager.on_score_updated.emit(_attemps)
	
func on_cup_destroy() -> void:
	_cups_hit += 1
	if _cups_hit == _total_cups:
		SignalManager.on_level_complete.emit()
		ScoreManager.set_score_for_level(_attemps, str(_level_number))	
