extends Node2D

@onready var WordBox = preload("res://interface/word_box.tscn")
@onready var sfx = $CreateSFX

var is_hidden = false

func _ready() -> void:
	SignalBus.shop_clicked.connect(_on_shop_clicked)

func _on_line_edit_new_word_typed(word: String) -> void:
	
	sfx.play()
	var new_word_container = WordBox.instantiate()
	new_word_container.create(word)
	$ScrollContainer/HFlowContainer.add_child(new_word_container)
	$ScrollContainer/HFlowContainer.sort_children()
	
# Hide the WordBoc so it doesn't cover the shop
func _on_shop_clicked():
	if is_hidden:
		self.show()
	else:
		self.hide()
		
	is_hidden = !is_hidden
