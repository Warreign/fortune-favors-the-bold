extends Control


func _ready() -> void:
	SceneLoader.set_configuration({
		"scenes": {
			"customer1": "res://Levels/Customer0.tscn",
			"customer2": "res://Levels/Customer1.tscn",
			"main_menu": "res://MainMenu/MainMenu.tscn"
		},
		"path_to_progress_bar": "Container/ProgressBar",
		"loading_screen": "res://General/LoadingScreen.tscn"
	})


func _on_start_pressed() -> void:
	SceneLoader.load_scene(self, "customer1", "Customer #1")


func _on_exit_pressed() -> void:
	get_tree().quit()
