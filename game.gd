extends Node2D
# Dimensions: Lucas art 112*112 480 * 360
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# These are tests that can be deleted later
	#print(WordDictionary.contains("health"))
	#print(WordDictionary.contains("healtt"))
	
	$WordBox.set_text("Hi!")
	# pass	
	
	

# Ordering (z index)
# Monkey = 5
# Label (in Monkey) = 7
# TextBoundary (in Monkey) = 6
