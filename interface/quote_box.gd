extends Area2D

const unwanted_chars = [".",",",":","?",";","\'","!","&","-","/","\""]

var word_list: Array
var quote: String
@onready var text_selector: Node2D = $TextSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_selector.update_level()
	text_selector.update_level()
	text_selector.update_level()
	quote = text_selector.get_random_quote()
	print(quote)
	# Create a list of words
	word_list = quote.split(" ")
	# Remove punctuation # TODO Fix this
	for word in word_list:
		for c in unwanted_chars:
			word = word.replace(c,"")
	# TODO Remove doubles of words from word_list
	print(word_list)
	
