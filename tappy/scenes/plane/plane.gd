class_name Tappy extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound

const GRAVITY: float = 1500.0
const FLY_FORCE: float = -500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	fly()
	move_and_slide()
	
	if is_on_floor():
		die()

func fly() -> void:
	if Input.is_action_just_pressed("fly"):
		velocity.y = FLY_FORCE
		animation_player.play("power")

func die() -> void:
	animated_sprite_2d.stop()
	sound.stop()
	set_physics_process(false)
	SignalManager.on_plane_die.emit()
