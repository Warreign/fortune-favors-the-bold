extends CharacterBody2D


# inspiration https://forum.godotengine.org/t/move-character-body-with-mouse/41818/4
const SPEED := 50.0

func _physics_process(_delta: float) -> void:
	if not $"../..".is_paused:
		var mouse_pos := get_global_mouse_position()
		mouse_pos.x -= $ColorRect.size.x
		mouse_pos.y -= $ColorRect.size.y
		
		var diff := mouse_pos - global_position
		velocity = diff * SPEED
		move_and_slide()
