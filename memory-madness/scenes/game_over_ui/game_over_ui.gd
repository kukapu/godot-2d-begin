extends Control

@onready var moves_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/MovesLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)


func on_game_over(moves: int) -> void: 
	moves_label.text = "You took %d moves" % moves
	show()


func _on_exit_button_pressed() -> void:
	hide()
	SignalManager.on_game_exit_pressed.emit()


func on_game_exit_pressed() -> void:
	hide()
