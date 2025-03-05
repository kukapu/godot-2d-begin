extends Node2D

const PIPES: PackedScene = preload("res://scenes/pipes/pipes.tscn")

@onready var spawn_up: Marker2D = $SpawnUp
@onready var spawn_down: Marker2D = $SpawnDown
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.set_score(0)
	SignalManager.on_plane_die.connect(_on_plane_die)
	spawn_pipes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_up.position.y, spawn_down.position.y)
	new_pipes.position = Vector2(spawn_up.position.x, yp)
	pipes_holder.add_child(new_pipes)

# func stop_pipes() -> void:
# 	spawn_timer.stop()
# 	for pipe in pipes_holder.get_children():
# 		pipe.set_process(false)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()


func _on_plane_die() -> void:
	spawn_timer.stop()
	# stop_pipes()
