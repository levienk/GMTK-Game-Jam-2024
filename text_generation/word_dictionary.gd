class_name WordDictionary extends Node

# Create an array of valid words
static var file = FileAccess.open("res://assets/text/dictionary.txt", FileAccess.READ)
static var raw_text = file.get_as_text(true)
static var dict = raw_text.split("\n")

# Contains a list of words that the user has unlocked
static var unlocked: Array
	
# Check a String against the WordDictionary, returns bool
static func contains(word: String):
	if dict.has(word):
		unlocked.append(word)
		return true
	else:
		return false
	return dict.has(word)
