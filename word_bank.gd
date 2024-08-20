extends Node2D

@onready var WordBox = preload("res://interface/word_box.tscn")
@onready var sfx = $CreateSFX

func _on_line_edit_new_word_typed(word: String) -> void:
	
	sfx.play()
	var new_word_container = WordBox.instantiate()
	new_word_container.create(word)
	$ScrollContainer/HFlowContainer.add_child(new_word_container)
	$ScrollContainer/HFlowContainer.sort_children()
	
