extends CanvasLayer

var current_customer_num: int
@onready var percent_label: Label = $Container/InfoContainer/StatsContainer/PercentStat/Value
@onready var num_label: Label = $Container/InfoContainer/StatsContainer/CustomerStat/Value
@onready var main_title_label: Label = $Container/InfoContainer/Title

const FULLY_SHAVED_TITLE: String = "Perfectly shaved!"

func initialize_level_end(customer_num: int, percent: float, is_timeout: bool):
	current_customer_num = customer_num
	percent_label.set_text(String.num(percent, 2))
	num_label.set_text(String.num_int64(customer_num))
	
	if customer_num == 6:
		$Container/InfoContainer/StatsContainer/Buttons/Next.hide()
	
	if not is_timeout:
		main_title_label.set_text(FULLY_SHAVED_TITLE)

func _on_exit_pressed() -> void:
	SceneLoader.load_scene(get_parent(), "main_menu", "Returning to menu")
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var next_customer_num = current_customer_num + 1;
	SceneLoader.load_scene(get_parent(), "customer" + String.num_int64(next_customer_num), "Customer #" + String.num_int64(next_customer_num))
	pass # Replace with function body.
