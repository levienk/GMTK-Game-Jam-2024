extends Area2D

const unwanted_chars = [".",",",":","?",";","!","&","-","/","\"","—"]

var used_quotes = []
var word_list: Array
var quote: String
@onready var text_selector: Node2D = $TextSelector
@onready var label: RichTextLabel = $RichTextLabel
@onready var beep = $PointsSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_new_quote()
	SignalBus.send_word_to_quote.connect(_on_send_word_to_quote)
	
func get_new_quote():
	
	# Make the since beep sound.
	# (but not initially...)
	if Points.points > 0:
		beep.play() 
	
	# Update the level and recieve the quote
	if Points.points == 30:
		quote = "You win!"
	# 7 1, 6 2, 555, 2
	# Update every two points, and not when the game first launches
	elif Points.points == 7:
		text_selector.update_level()
		quote = text_selector.get_random_quote()
	elif Points.points == 13:
		text_selector.update_level()
		quote = text_selector.get_random_quote()
	elif Points.points == 18:
		text_selector.update_level()
		quote = text_selector.get_random_quote()
	elif Points.points == 23:
		text_selector.update_level()
		quote = text_selector.get_random_quote()
	elif Points.points == 28:
		text_selector.update_level()
		quote = text_selector.get_random_quote()
	else:
		quote = text_selector.get_random_quote()
	label.bbcode_text = quote
	
	# Don't reuse the same quote
	while used_quotes.has(quote):
		quote = text_selector.get_random_quote()
	used_quotes.append(quote)
	
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
	word_list.erase("")
	print(word_list)
	
	# Update Monkey quote_word_list
	SignalBus.new_quote_words.emit(word_list)
	
# From SignalBus WordBox button
# Change color of words in quote and update word_list when WordBox entered
func _on_send_word_to_quote(word: String):
	if word_list.has(word):
		word_list.erase(word)
		# The quote has been completed!
		if word_list.is_empty():
			Points.add_point()
			get_new_quote()
			return
		# Change color of quote
		var regex = RegEx.new()
		regex.compile("\\b(?i)" + word + "(?-i)\\b(.|,|:|;|\\?|!|'|&|-|—|’|\")?")
		for result in regex.search_all(quote):
			quote = quote.replace(result.get_string(), "[color=blue]" + result.get_string() + "[/color]")
			label.bbcode_text = quote
	
# Remove duplicates from an array
func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)
	return unique
