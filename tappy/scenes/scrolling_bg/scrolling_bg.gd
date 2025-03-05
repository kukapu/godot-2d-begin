extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_plane_die.connect(on_plane_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x -= GameManager.SCROLL_SPEED * delta

func on_plane_die() -> void:
	set_process(false)
