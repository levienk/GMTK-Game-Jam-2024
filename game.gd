extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# These are tests that can be deleted later
	#print(WordDictionary.contains("health"))
	#print(WordDictionary.contains("healtt"))
	
	# These are tests for the TextCard, and can be deleted later.
	
	$WordCard.set_text("This")
	
	$WordCard2.set_text("works")
	
	$WordCard3.set_text("well.")
	
	
	

# Ordering (z index)
# Monkey = 5
# Label (in Monkey) = 6
