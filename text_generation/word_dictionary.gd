extends Node

# THIS IS A SINGLETON (global)

# Create an array of valid words
static var file = FileAccess.open("res://assets/text/quotes_dictionary.txt", FileAccess.READ)
static var raw_text = file.get_as_text(true)
static var dict = raw_text.split("\n")
	
# Check a String against the WordDictionary, returns bool
static func contains(word: String) -> bool:
	var index = dict.find(word)
	if (index == -1):
		return false
	elif (dict[index] != word):
		return false
	else:
		return true

static func get_random() -> String:
	return dict[randi() % dict.size()]
