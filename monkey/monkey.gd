extends Node2D

# Set textures for the TextBoundary
static var invalid_texture = load("res://assets/art/textures/Invalid.png")
static var valid_texture = load("res://assets/art/textures/Valid.png")

static var random_time = 1
static var valid_time = 6.0
static var valid_word_chance = 0.1
# Must be less than valid_word_chance
static var valid_word_in_quote_chance = 0.02
static var max_word_length = 10

static var quote_word_list: Array
const possible_chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n",
						"o","p","q","r","s","t","u","v","w","x","y","z"]
var random_word: String

@onready var timer: Timer = $Timer
@onready var text_boundary: NinePatchRect = $TextBoundary

func _ready() -> void:
	SignalBus.new_quote_words.connect(_on_new_quote_words)

func _on_timer_timeout() -> void:
	timer.stop()
	random_word = ""
	var rand = randf()
	
	# Generate random word
	if (rand < valid_word_in_quote_chance):
		# The word is generated from the quote
		random_word = quote_word_list.pick_random()
	elif (rand < valid_word_chance):
		# The word is generated from the dictionary
		random_word = WordDictionary.get_random()
	else:
		# The word is randomly generated
		for i in range(randi() % max_word_length + 1):
			random_word += possible_chars.pick_random()
	
	if (WordDictionary.contains(random_word)):
		SignalBus.word_found.emit(random_word)
		timer.wait_time = valid_time
		text_boundary.texture = valid_texture
	else:
		timer.wait_time = random_time
		text_boundary.texture = invalid_texture
		
	timer.start()
	$Label.text = random_word

# SignalBus new_quote_words (from QuoteBox)
func _on_new_quote_words(words):
	quote_word_list = words
