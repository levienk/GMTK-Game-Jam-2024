extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create(word: String) -> void:
	
	$WordBox.set_text(word)
	
	self.custom_minimum_size = $WordBox/TextBoundary.size
