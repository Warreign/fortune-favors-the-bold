extends CanvasLayer

var current_customer_num: int
@onready var percent_label: Label = $Container/StatsContainer/PercentStat/Value
@onready var num_label: Label = $Container/StatsContainer/CustomerStat/Value

func initialize_level_end(customer_num: int, percent: float):
	current_customer_num = customer_num
	percent_label.set_text(String.num(percent))
	num_label.set_text(String.num_int64(customer_num))

func _on_exit_pressed() -> void:
	SceneLoader.load_scene(get_parent(), "main_menu", "Returning to menu")
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var next_customer_num = current_customer_num + 1;
	SceneLoader.load_scene(get_parent(), "customer" + String.num_int64(next_customer_num), "Customer #" + String.num_int64(next_customer_num))
	pass # Replace with function body.
