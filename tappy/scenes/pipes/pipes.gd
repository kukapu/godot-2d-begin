class_name Pipes extends Node2D

const OFF_SCREEN: float = -500.0

@onready var score_sound: AudioStreamPlayer = $ScoreSound

func _ready() -> void:
	SignalManager.on_plane_die.connect(on_plane_die)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_pipes(delta)
	
func move_pipes(delta: float) -> void:
	position.x -= delta * GameManager.SCROLL_SPEED
	check_off_screen()
	
func check_off_screen() -> void:
	if position.x < OFF_SCREEN:
		queue_free()

func _on_screen_exited() -> void:
	queue_free()

func on_plane_die() -> void:
	set_process(false)


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()
	# if body.is_in_group(GameManager.GROUP_PLANE):
	# 	if body.has_method("die"):
	# 		body.die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is Tappy:
		ScoreManager.increent_score()
		score_sound.play()
