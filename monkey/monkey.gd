extends Node2D

static var random_time = 0.5
static var valid_time = 3.0
static var valid_word_chance = 0.1
# Must be less than valid_word_chance
static var valid_word_in_quote_chance = 0.05
static var max_word_length = 10

const possible_chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n",
						"o","p","q","r","s","t","u","v","w","x","y","z"]
var random_word: String

const bells = [
	"res://assets/sfx/typewriter_bell_1.wav",
	"res://assets/sfx/typewriter_bell_2.wav",
	"res://assets/sfx/typewriter_bell_3.wav",
	"res://assets/sfx/typewriter_bell_4.wav",
	"res://assets/sfx/typewriter_bell_5.wav"
	]
const typing_sounds = [
	"res://assets/sfx/typewriter_writing_1.wav",
	"res://assets/sfx/typewriter_writing_2.wav",
	"res://assets/sfx/typewriter_writing_3.wav",
]

@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var sounds: AudioStreamPlayer = $Typing
@onready var bell: AudioStreamPlayer = $Bell

func _ready() -> void:
	
	# Randomly choose a bell sound for the typewriter
	var bell_sound
	var typing_sound
	match randi() % 5:
		
		0:
			bell_sound = preload("res://assets/sfx/typewriter_bell_1.wav")
			print("b1")
		1:
			bell_sound = preload("res://assets/sfx/typewriter_bell_2.wav")
			print("b2")
		2:
			bell_sound = preload("res://assets/sfx/typewriter_bell_3.wav")
			print("b3")
		3:
			bell_sound = preload("res://assets/sfx/typewriter_bell_4.wav")
			print("b4")
		_:
			bell_sound = preload("res://assets/sfx/typewriter_bell_5.wav")
			print("b5")
	
	match randi() % 3:
		
		0:
			typing_sound = preload("res://assets/sfx/typewriter_writing_1.wav")
		1:
			typing_sound = preload("res://assets/sfx/typewriter_writing_2.wav")
		_:
			typing_sound = preload("res://assets/sfx/typewriter_writing_3.wav")
	
	
	sounds.stream = typing_sound
	bell.stream = bell_sound
	
	# Start the typing sound.
	sounds.play()
	
func _on_timer_timeout() -> void:
	
	timer.stop()
	random_word = ""
	var rand = randf()
	
	# Generate random word
	if (rand < valid_word_in_quote_chance):
		# TODO The word is generated from the quote
		random_word = WordDictionary.get_random()
		bell.play()
		print("Got word!")
	elif (rand < valid_word_chance):
		# The word is generated from the dictionary
		random_word = WordDictionary.get_random()
		bell.play()
		print("Got word!")
	else:
		# The word is randomly generated
		for i in range(randi() % max_word_length + 1):
			random_word += possible_chars.pick_random()
	
	if (WordDictionary.contains(random_word)):
		SignalBus.word_found.emit(random_word)
		timer.wait_time = valid_time
	else:
		timer.wait_time = random_time
		
	timer.start()
	label.text = random_word
	
