extends Node2D

const pause_widget_path: String = "res://General/PauseMenu.tscn"
const level_end_widget_path: String = "res://General/LevelEnd.tscn"

@export var customer_number: int = 0

var _is_paused: bool
var is_paused: bool:
	get:
		return _is_paused
	set(value):
		_is_paused = value
		

func _process(delta: float):
	if Input.is_action_just_pressed("to_main_menu"):
		SceneLoader.load_scene(self, "main_menu", "Menu")
		
	if not is_paused:
		if Input.is_action_just_pressed("pause"):
			var pause_menu_instance = preload(pause_widget_path).instantiate()
			add_child(pause_menu_instance)
			is_paused = true;
			
		if Input.is_action_just_pressed("_end_level"):
			var level_end_instance = preload(level_end_widget_path).instantiate()
			level_end_instance.initialize_level_end(customer_number)
			add_child(level_end_instance)
