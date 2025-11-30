class_name TextBubble
extends CanvasLayer

@export var bubble_text: String

func set_bubble_text(text: String) -> void:
	$Control/Text.set_text(text)
	
