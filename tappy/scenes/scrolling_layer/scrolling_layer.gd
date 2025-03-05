extends ParallaxLayer

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var texture: Texture2D
# La velocidad a la que se mueve todo (normalmente la camara)
@export var scroll_scale: float = 0.0

const IMG_W: float = 1920.0
const IMG_H: float = 1080.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion_scale.x = scroll_scale
	var scale_f = get_viewport_rect().size.y / IMG_H
	sprite_2d.texture = texture
	sprite_2d.scale = Vector2(scale_f, scale_f)
	motion_mirroring.x = IMG_W * scale_f

	
