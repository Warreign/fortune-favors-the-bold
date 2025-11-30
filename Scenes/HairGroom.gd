extends Node2D

signal level_ended(is_timeout: bool, percent: float)

func _ready() -> void:
	$HairSpawner.end.connect(_emit_end)
	pass
	
func _emit_end(is_timeout: bool, percent: float) -> void:
	level_ended.emit(is_timeout, percent)
	
func _end_print(is_timeout: bool, percent: float) -> void:
	print("Level ended " + String.chr(is_timeout) + " " + String.num(percent, 2))

func launch_game() -> void:
	$HairSpawner/ThinkTimer.start()
	pass
	
func is_running() -> bool:
	return not $HairSpawner/ThinkTimer.is_stopped()
