extends CanvasLayer

var current_customer_num: int

func initialize_level_end(customer_num: int):
	current_customer_num = customer_num

func _on_exit_pressed() -> void:
	SceneLoader.load_scene(get_parent(), "main_menu", "Returning to menu")
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var next_customer_num = current_customer_num + 1;
	SceneLoader.load_scene(get_parent(), "customer" + String.num_int64(next_customer_num), "Customer #" + String.num_int64(next_customer_num))
	pass # Replace with function body.
