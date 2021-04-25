extends Node

var loader : ResourceInteractiveLoader
var load_screen : Control
onready var gamedata = load("res://Code/GameData.gd").new()

func _ready():
	set_process(false)

func load_scene(name):
	loader = ResourceLoader.load_interactive("res://Scenes/"+name+".tscn")
	if loader == null:
		print("Wrong scene name")
		return
	for child in get_tree().root.get_children():
		if child.name != self.name:
			child.queue_free()
	load_screen = load("res://Scenes/LoadingScreen.tscn").instance()
	get_tree().change_scene("res://Scenes/LoadingScreen.tscn")
	set_process(true)

func _process(_delta):
	if loader != null:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			var scene_resource = loader.get_resource()
			loader = null
			load_screen.queue_free()
			get_tree().change_scene_to(scene_resource)

