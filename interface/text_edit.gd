extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.word_found.connect(_on_word_found)


func _on_word_found(word: String):
	print(word)
