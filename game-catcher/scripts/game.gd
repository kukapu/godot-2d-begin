extends Node2D

@export var gem_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_off_outside_gem() -> void:
	print("Game Over")

func spawn_gem() -> void:
	var gem = gem_scene.instantiate()
	# gem.position = Vector2(randi_range(0, get_viewport_rect().size.x), 0)
	add_child(gem)


func _on_timer_timeout_spanw_gem() -> void:
	spawn_gem()