extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_DEFAULT: Vector2 = Vector2(1.0, 1.0)
const SPIN_TIME_RANGE: Vector2 = Vector2(1.0, 2.0)
const SCALE_TIME: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_image()
	run_me()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_random_image() -> void:
	texture = ImageManager.get_random_item_image().get_texture()

func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))


func run_me() -> void:
	pass
	# make a tween
	var tween: Tween = get_tree().create_tween()
	## tween.set_loops(0) El problema de esto es que los valores de get para la rotacion solo se calculan en la primera
	## por lo que a partir de ahi ya no girarian
	## SOLUCIONES
	## 1. usar la señar de cuando acaba el tween y usar otro tween para generar esos valores
	## 2. callback con la propia funcion con recursividad
	## 3. Instanciar los valores en el script
	### HAY QUE TENER CUIDADO CON LOS EFECTOS SECUNDARIOS DE LOS TWEENS
	# scale -> SMALL
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)
	# set_random_image
	tween.tween_callback(set_random_image)
	# scale -> DEFAULT
	tween.tween_property(self, "scale", SCALE_DEFAULT, SCALE_TIME)
	# rotation rand amount, random time
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	# run_me
	tween.tween_callback(run_me)
