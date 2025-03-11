extends TextureButton

@export var level_number: int = 1

@onready var label: Label = $Label
@onready var sound: AudioStreamPlayer = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_data: LevelData = GameManager.get_level_data(level_number)
	label.text = "%dx%d" % [
		level_data.get_cols(),
		level_data.get_row()
	]




func _on_pressed() -> void:
	SoundManager.play_button_click(sound)
	SignalManager.on_level_selected.emit(level_number)
