extends TextureRect

const max_length = 140

func _ready() -> void:
	if $Label.size.x > max_length:
		$Label.clip_text = true
		$Label.size.x = max_length
		
	size = $Label.size
	if $Label.size.x > 25:
		size.x += 16
	
