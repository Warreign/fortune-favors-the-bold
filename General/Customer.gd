extends Node2D

const pause_widget_path: String = "res://General/PauseMenu.tscn"
const level_end_widget_path: String = "res://General/LevelEnd.tscn"

@onready var text_bubble: TextBubble = $TextBubble

@export var customer_number: int = 0

var _is_paused: bool = false
var is_paused: bool:
	get:
		return _is_paused
	set(value):
		_is_paused = value

var level_end = false

func _ready() -> void:
	$HairGroom.level_ended.connect(_on_level_end)

func initialize_end_screen(shave_percent: float, customer_num: int):
	var level_end_instance = preload(level_end_widget_path).instantiate()
	add_child(level_end_instance)
	level_end_instance.initialize_level_end(customer_num, shave_percent)


func _process(delta: float):
	#if Input.is_action_just_pressed("to_main_menu"):
		#SceneLoader.load_scene(self, "main_menu", "Menu")
		
	if not is_paused:
		if not $HairGroom.is_running() and Input.is_action_just_pressed("start_shaving"):
			start_game()
		
		if Input.is_action_just_pressed("pause"):
			var pause_menu_instance = preload(pause_widget_path).instantiate()
			add_child(pause_menu_instance)
			is_paused = true;
			
		if Input.is_action_just_pressed("_end_level"):
			_on_level_end(true, 50);


func _on_level_end(is_timeout: bool, percent_shaved: float):
	var level_end_instance = preload(level_end_widget_path).instantiate()
	add_child(level_end_instance)
	level_end_instance.initialize_level_end(customer_number, percent_shaved, is_timeout)
	is_paused = true;
	
func start_game() -> void:
	$HairGroom.launch_game()
	text_bubble.hide()
