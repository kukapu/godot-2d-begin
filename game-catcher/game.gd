extends Node2D

const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene: PackedScene

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_off_outside_gem() -> void:
	print("Game Over")

func spawn_gem() -> void:
	var gem: Gem = gem_scene.instantiate()
	var randomX = randf_range(20,1100)
	gem.on_off_outside_gem.connect(game_over)
	gem.position = Vector2(randomX, -30)
	add_child(gem)
	
func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func play_explode() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()
	
func game_over() -> void:
	stop_all()
	play_explode()

func _on_timer_timeout_spanw_gem() -> void:
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	label.text = "%05d" % _score
	audio_stream_player_2d.play()
	area.queue_free()
