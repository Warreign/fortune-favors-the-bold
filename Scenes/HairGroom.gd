extends Node2D

signal level_ended(is_timeout: bool, percent: float)

@onready var end_timer: Timer = $HairSpawner/EndTimer
@onready var sparkles: Sprite2D = $Sparkles

func _ready() -> void:
	$HairSpawner.end.connect(_emit_end)
	pass
	
func _emit_end(is_timeout: bool, percent: float) -> void:
	var emit_end_signal = func ():
		level_ended.emit(is_timeout, percent)
		
	$"..".is_paused = true
		
	if not is_timeout:
		sparkles.show()
		end_timer.timeout.connect(emit_end_signal)
		end_timer.start()
	else:
		emit_end_signal.call()
	
func _end_print(is_timeout: bool, percent: float) -> void:
	print("Level ended " + String.chr(is_timeout) + " " + String.num(percent, 2))

func launch_game() -> void:
	$HairSpawner/ThinkTimer.start()
	pass
	
func is_running() -> bool:
	return not $HairSpawner/ThinkTimer.is_stopped()
