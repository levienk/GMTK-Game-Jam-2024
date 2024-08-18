extends NinePatchRect

func _on_label_resized() -> void:
	size.x = $"../Label".size.x
	size.x += 2
	position.x = - size.x / 2
