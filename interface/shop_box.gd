extends Area2D

var is_hidden = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SignalBus.shop_clicked.connect(_clicked)
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _clicked():
	
	if is_hidden:
		
		self.show()
	
	else:
		
		self.hide()
		
	is_hidden = !is_hidden
