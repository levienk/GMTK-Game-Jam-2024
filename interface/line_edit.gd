extends LineEdit

var words_found: Array
var words_not_typed: Array
var auto_mode = false

signal new_word_typed(word: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.stop()
	SignalBus.word_found.connect(_on_word_found)
	SignalBus.remove_last_word_found.connect(_on_remove_last_word_found)
	SignalBus.auto_1_enabled.connect(_on_auto_1_enabled)
	SignalBus.auto_2_enabled.connect(_on_auto_2_enabled)

# Recieve Signal
func _on_word_found(word: String):
	# If the word was not already found
	
	if not words_found.has(word) and not words_not_typed.has(word):
		if auto_mode:
			new_word_typed.emit(word)
			add_bananas(word)
			words_found.append(word)
		else:
			words_not_typed.append(word)
	
func _on_remove_last_word_found(word: String):
	words_not_typed.erase(word)
	
# When the user has entered a word
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("submit"):
		# Use special apostrophe
		text = text.replace("\'","’")
		var index = words_not_typed.find(text)
		# If the user typed a typable word
		if index != -1:
			add_bananas(text)
			words_not_typed.remove_at(index)
			words_found.append(text)
			new_word_typed.emit(text)
		clear()
		# Test
		print(words_found)
		print(words_not_typed)

func _on_auto_1_enabled():
	clear()
	placeholder_text = "AUTO..."
	editable = false
	auto_mode = true
	
	
func _on_auto_2_enabled():
	$Timer.start()
	
func _on_timer_timeout() -> void:
	for word in words_found:
		SignalBus.send_word_to_quote.emit(word)

func add_bananas(word: String):
	var points = 10 * word.length()
	Bananas.add_score(points)
