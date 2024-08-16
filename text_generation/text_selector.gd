extends Node2D

# Initialize the quotes at level 1
var file = FileAccess.open("res://assets/text/quotes1.txt", FileAccess.READ)
var raw_text: String
var current_quotes: Array

var level: int = 1

func _ready() -> void:
	update_quotes()
	print(current_quotes)
	
	update_level()
	print(current_quotes)
	
# Generate an array of possible quotes to use
func update_quotes():
	current_quotes.clear()
	raw_text = file.get_as_text(true)
	# Use @ as a delimiter between quotes
	current_quotes = raw_text.split("\n@\n")
	# Get rid of extra line at the end of the file
	current_quotes[-1] = current_quotes[-1].replace("\n", "")
	
	

# Connect this to a signal to wherever we store the level
func update_level():
	level += 1
	# Find the text file associated with each level of difficulty
	match level:
		2:
			file = FileAccess.open("res://assets/text/quotes2.txt", FileAccess.READ)
		3:
			file = FileAccess.open("res://assets/text/quotes3.txt", FileAccess.READ)
		4:
			file = FileAccess.open("res://assets/text/quotes4.txt", FileAccess.READ)
		_:
			print("Invalid level under update_level in text_selector.")
	update_quotes()
