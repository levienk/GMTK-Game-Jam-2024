extends TextureButton

func set_text(text: String) -> void:
	
	$TextBoundary/Label.text = text
	
	# Yes, both calls are required to update it...
	$TextBoundary._ready()
	$TextBoundary._ready()
	
	custom_minimum_size = $TextBoundary.size
	
func create(word: String) -> void:
	set_text(word)
