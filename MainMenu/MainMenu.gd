extends Control


func _ready() -> void:
	SceneLoader.set_configuration({
		"scenes": {
			"customer1": "res://Levels/customer1.tscn",
			"customer2": "res://Levels/customer2.tscn",
			"customer3": "res://Levels/customer3.tscn",
			"customer4": "res://Levels/customer4.tscn",
			"customer5": "res://Levels/customer5.tscn",
			"customer6": "res://Levels/customer6.tscn",
			"main_menu": "res://MainMenu/MainMenu.tscn"
		},
		"path_to_progress_bar": "Container/ProgressBar",
		"loading_screen": "res://General/LoadingScreen.tscn"
	})


func _on_start_pressed() -> void:
	SceneLoader.load_scene(self, "customer1", "Customer #1")


func _on_exit_pressed() -> void:
	get_tree().quit()
