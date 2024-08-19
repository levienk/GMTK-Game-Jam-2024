extends FlowContainer

@onready var WordBoxHolder = preload("res://word_box_holder.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func sort_children():
	
	# Get the kiddos of the FlowContainer
	var kids = get_children()
	# Sort the kiddos (as an array) by name.
	kids.sort_custom(_sort_by_name)
	#.sort_custom(_sort_by_name)
	
	for kid in kids:
		
		remove_child(kid)
		add_child(kid)
		
func _sort_by_name(a, b):
	
	var text_a = a.get_node("WordBox/TextBoundary/Label").text
	var text_b = b.get_node("WordBox/TextBoundary/Label").text
	return  text_a < text_b

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
