extends CanvasLayer


func _on_resume_button_pressed() -> void:
	get_parent().is_paused = false
	queue_free()
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	SceneLoader.load_scene(get_parent(), "main_menu", "Returning to menu");
	pass # Replace with function body.
