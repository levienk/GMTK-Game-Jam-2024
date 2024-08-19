extends Node2D

const size = Vector2(160, 280)
@onready var WordBox = preload("res://interface/word_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Make the collider the right size, in the right place.
	#var position = Vector2(
		#size.x / 2,
		#size.y / 2
	#)
	pass
	#$ScrollContainer.size = size
	#$ScrollContainer/FlowContainer.size = size
	#$ScrollContainer/FlowContainer.custom_minimum_size = size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print($ScrollContainer.size)
	print($ScrollContainer.custom_minimum_size)
	print($ScrollContainer/HFlowContainer.size)
	print($ScrollContainer/HFlowContainer.custom_minimum_size)
	
	pass


func _on_line_edit_new_word_typed(word: String) -> void:
	
	var new_word_container = WordBox.instantiate()
	new_word_container.create(word)
	$ScrollContainer/HFlowContainer.add_child(new_word_container)
	$ScrollContainer/HFlowContainer.sort_children()
	
