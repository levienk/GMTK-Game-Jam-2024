extends CenterContainer

const MARGIN = 12
var dragging = false
var touching = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.set_size(Vector2(100, 24))


func set_text(text: String):
	
	# Set Label text
	$Label.text = text
	
	# Get the size of the text
	var text_dims = $Label.get_minimum_size()
	print(text)
	print(text_dims)
	var buffed_size = Vector2((text_dims.x + MARGIN), text_dims.y + MARGIN)
	# Set the CenterContainer size to the text + MARGIN
	self.set_size(buffed_size)
	$NinePatchRect.custom_minimum_size = Vector2(buffed_size)
	print(buffed_size)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _input(event): 
	# If there's a click, let the user drag.
	if event is InputEventMouseButton:
		
		if event.pressed:
			
			dragging = true
		
		else:
			
			dragging = false
		
	elif event is InputEventMouseMotion and touching and dragging:
		
		self.position += event.relative
		
	# Register C

func _on_mouse_entered() -> void:
	
	touching = true


func _on_mouse_exited() -> void:
	
	touching = false
