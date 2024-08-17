extends Node2D

@export var random_time = 0.5
@export var valid_time = 3.0
@export var valid_word_chance = 0.1
@export var max_word_length = 10

var possible_chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n",
						"o","p","q","r","s","t","u","v","w","x","y","z"]
var random_word: String

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _on_timer_timeout() -> void:
	timer.stop()
	random_word = ""
	# Generate random word
	if (randf() > valid_word_chance):
		# The word is randomly generated
		for i in range(randi() % max_word_length + 1):
			random_word += possible_chars.pick_random()
	else:
		# The word is generated from the dictionary
		random_word = WordDictionary.get_random()
	
	if (WordDictionary.contains(random_word)):
		timer.wait_time = valid_time
	else:
		timer.wait_time = random_time
		
	timer.start()
	label.text = random_word
	
