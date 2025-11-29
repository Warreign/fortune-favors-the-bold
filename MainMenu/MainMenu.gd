extends Control


func _ready() -> void:
	SceneLoader.set_configuration({
		"scenes": {
			"customer": "res://Levels/Customer.tscn",
			"customer2": "res://Levels/Customer2.tscn",
			"main_menu": "res://MainMenu/MainMenu.tscn"
		},
		"path_to_progress_bar": "Container/ProgressBar",
		"loading_screen": "res://General/LoadingScreen.tscn"
	})


func _on_start_pressed() -> void:
	SceneLoader.load_scene(self, "customer", "Customer #1")


func _on_exit_pressed() -> void:
	get_tree().quit()
