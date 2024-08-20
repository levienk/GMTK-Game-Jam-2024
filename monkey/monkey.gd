extends Node2D

const random_time_const = 1
const valid_time_const = 5.0
const valid_word_chance_const = 0.07
const valid_word_in_quote_chance_const = 0.015

# Set textures for the TextBoundary
static var invalid_texture = load("res://assets/art/textures/Invalid.png")
static var valid_texture = load("res://assets/art/textures/Valid.png")

static var random_time = random_time_const
static var valid_time = valid_time_const
static var valid_word_chance = valid_word_chance_const
# Must be less than valid_word_chance
static var valid_word_in_quote_chance = valid_word_in_quote_chance_const
static var max_word_length = 10

static var quote_word_list: Array
const possible_chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n",
						"o","p","q","r","s","t","u","v","w","x","y","z"]
var random_word: String
var previous_valid_word: String

# Animation
@onready var animated_monkey: AnimatedSprite2D = $AnimatedMonkey
@onready var animated_typewriter: AnimatedSprite2D = $AnimatedMonkey/AnimatedTypewriter
const animations = ["monkey1_typing_1_1","monkey1_typing_1_2","monkey1_typing_1_3",
					"monkey1_typing_2_1","monkey1_typing_2_2","monkey1_typing_2_3",
					"monkey1_frustrated_1_1","monkey1_frustrated_1_2","monkey1_frustrated_1_3",
					"monkey1_frustrated_2_1","monkey1_frustrated_2_2"]
const rand1_anim = ["monkey1_frustrated_2_1", "monkey1_frustrated_1_1"]
const rand2_anim = ["monkey1_frustrated_1_3","monkey1_typing_2_1"]
const rand3_anim = ["monkey1_typing_1_1", "monkey1_frustrated_2_1","monkey1_frustrated_1_1"] 

@onready var timer: Timer = $Timer
@onready var text_boundary: NinePatchRect = $TextBoundary

# Sound-related
@onready var ding = $Ding
@onready var type = $Type

func _ready() -> void:
	SignalBus.new_quote_words.connect(_on_new_quote_words)
	SignalBus.speed_1_enabled.connect(_on_speed_1_enabled)
	SignalBus.speed_2_enabled.connect(_on_speed_2_enabled)
	SignalBus.intellect_1_enabled.connect(_on_intellect_1_enabled)
	SignalBus.intellect_2_enabled.connect(_on_intellect_2_enabled)
	
	load_sounds()
	type.play()
	
	#animated_monkey.play(animations[0])

func _on_timer_timeout() -> void:
	SignalBus.remove_last_word_found.emit(previous_valid_word)
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
		previous_valid_word = random_word
		timer.wait_time = valid_time
		text_boundary.texture = valid_texture
		ding.play()
	else:
		timer.wait_time = random_time
		text_boundary.texture = invalid_texture
		
	timer.start()
	$Label.text = random_word

# SignalBus new_quote_words (from QuoteBox)
func _on_new_quote_words(words):
	quote_word_list = words

func _on_speed_1_enabled():
	random_time = random_time_const / 1.5
	
func _on_speed_2_enabled():
	random_time = random_time_const / 2.0
	valid_time = valid_time_const / 2.0

func _on_intellect_1_enabled():
	valid_word_chance = valid_word_chance_const * 1.5
	valid_word_in_quote_chance = valid_word_in_quote_chance_const * 1.5

func _on_intellect_2_enabled():
	valid_word_chance = valid_word_chance_const * 2
	valid_word_in_quote_chance = valid_word_in_quote_chance_const * 2

func load_sounds():
	
	# Load the dingy sounds
	match randi() % 5:
		
		0:
			ding.stream = preload("res://assets/sfx/typewriter_bell_1.wav") as AudioStreamWAV
		1:
			ding.stream = preload("res://assets/sfx/typewriter_bell_2.wav") as AudioStreamWAV
		3:
			ding.stream = preload("res://assets/sfx/typewriter_bell_3.wav") as AudioStreamWAV
		4:
			ding.stream = preload("res://assets/sfx/typewriter_bell_4.wav") as AudioStreamWAV
		_:
			ding.stream = preload("res://assets/sfx/typewriter_bell_5.wav") as AudioStreamWAV
			
	# Load the typing sounds
	match randi() % 3:
		
		0:
			type.stream = preload("res://assets/sfx/typewriter_writing_1.wav") as AudioStreamWAV
		1:
			type.stream = preload("res://assets/sfx/typewriter_writing_2.wav") as AudioStreamWAV
		2:
			type.stream = preload("res://assets/sfx/typewriter_writing_3.wav") as AudioStreamWAV
		


# Needed to keep the audio looping.
func _on_type_finished() -> void:
	
	type.play()


func _on_animated_monkey_animation_finished() -> void:
	pass
	#var rand_limit = 0.1
	## Loop 1
	#if animated_monkey.animation == animations[0]:
		#animated_monkey.animation = animations[1]
		#animated_monkey.play()
	#if animated_monkey.animation == animations[1] && randf() < rand_limit:
		#animated_monkey.animation = animations[2]
		#animated_monkey.play()
	#else:
		#animated_monkey.play()
	#if animated_monkey.animation == animations[2]:
		#animated_monkey.animation = rand1_anim.pick_random()
		#animated_monkey.play()
	#
	## Loop 2
	#if animated_monkey.animation == animations[9] && randf() < rand_limit:
		#animated_monkey.animation = animations[10]
		#animated_monkey.play()
	#else:
		#animated_monkey.play()
	#if animated_monkey.animation == animations[10]:
		#animated_monkey.animation = rand3_anim.pick_random()
		#animated_monkey.play()
		#
	## Loop 3
	#if animated_monkey.animation == animations[6]:
		#animated_monkey.animation = animations[7]
		#animated_monkey.play()
	#if animated_monkey.animation == animations[7] && randf() < rand_limit:
		#animated_monkey.animation = rand2_anim.pick_random()
		#animated_monkey.play()
	#else:
		#animated_monkey.play()
	#if animated_monkey.animation == animations[8]:
		#animated_monkey.animation = rand3_anim.pick_random()
		#animated_monkey.play()
#
	## Loop 4
	#if animated_monkey.animation == animations[3]:
		#animated_monkey.animation = animations[4]
	#if animated_monkey.animation == animations[4] && randf() < rand_limit:
		#animated_monkey.animation = animations[5]
		#animated_monkey.play()
	#else:
		#animated_monkey.play()
	#if animated_monkey.animation == animations[5]:
		#animated_monkey.animation = animations[8]
		#animated_monkey.play()
