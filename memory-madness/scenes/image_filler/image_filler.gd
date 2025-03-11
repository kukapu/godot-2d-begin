# @tool
# Para ejecutar codigo desde el editor. Se ejecuta cuando abres la escena
extends Node

const PATH: String = 'res://assets/glitch/'

func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH)
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		
		var ifl: ImageFileList = ImageFileList.new()
		
		for file in files:
			ifl.add_filename(PATH + file)
	
		ResourceSaver.save(ifl, "res://resources/image_files_list.tres")
