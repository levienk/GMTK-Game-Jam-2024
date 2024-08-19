extends LineEdit

var words_found: Array
var words_not_typed: Array

signal new_word_typed(word: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.word_found.connect(_on_word_found)

# Recieve Signal
func _on_word_found(word: String):
	# If the word was not already found
	if not words_found.has(word) and not words_not_typed.has(word):
		words_not_typed.append(word)
	
# When the user has entered a word
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("submit"):
		# Use special apostraphe
		text = text.replace("\'","’")
		print(text)
		var index = words_not_typed.find(text)
		# If the user typed a typable word
		if index != -1:
			# TODO ADD SCORE
			words_not_typed.remove_at(index)
			words_found.append(text)
			new_word_typed.emit(text)
		clear()
		# Test
		print(words_found)
		print(words_not_typed)
