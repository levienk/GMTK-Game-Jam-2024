extends Area2D

const unwanted_chars = [".",",",":","?",";","\'","!","&","-","/","\"","’","—"]

var word_list: Array
var quote: String
@onready var text_selector: Node2D = $TextSelector
@onready var label: RichTextLabel = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_new_quote()
	
func get_new_quote():
	# Update the level and recieve the quote
	text_selector.update_level()
	text_selector.update_level()
	text_selector.update_level()
	text_selector.update_level()
	text_selector.update_level()
	quote = text_selector.get_random_quote()
	label.bbcode_text = quote
	
	# Create a list of words
	word_list.clear()
	var regex = RegEx.new()
	regex.compile("\\S+") # Negated whitespace character class.
	for result in regex.search_all(quote):
		word_list.push_back(result.get_string())
	# Remove punctuation
	for index in range(word_list.size()):
		for c in unwanted_chars:
			word_list[index] = word_list[index].replace(c,"")
		# Lowercase
		word_list[index] = word_list[index].to_lower()
	# Remove doubles of words from word_list
	word_list = array_unique(word_list)
	print(word_list)
	
	# Update Monkey quote_word_list
	SignalBus.new_quote_words.emit(word_list)
	
# TODO Change color of words in quote and update word_list when WordBox entered
func _on_area_entered(word: String):
	# TODO NOT LINKED YET
	if word_list.has(word):
		word_list.erase(word)
		# The quote has been completed!
		if word_list.is_empty():
			# TODO UPDATE SCORE
			get_new_quote()
			return
		# Change color of quote
		var regex = RegEx.new()
		regex.compile("\b" + word + "\b(?:('|’)(s|t))(?:'|’|!|)")
		for result in regex.search_all(quote):
			pass
	
# Remove duplicates from an array
func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)
	return unique
