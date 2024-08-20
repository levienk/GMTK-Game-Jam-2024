extends Node2D
# Dimensions: Lucas art 112*112 480 * 360
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start of game currency
	Bananas.bananas = 200

# Ordering (z index)
# Monkey = 5
# Label/TextBoundary (in Monkey) = 6
# WordBox = 8
