extends Node2D



static var bananas = 0

static func add_score(score: int):
	bananas += score

static func subtract_score(score: int) -> bool:
	if bananas < score:
		return false
	else:
		bananas -= score
		return true

func _ready() -> void:
	
	SignalBus.shop_clicked.connect(_clicked)

func _clicked(): 
	
	pass
	
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	
	if event is InputEventMouseButton:
		
		if event.pressed:
			
			SignalBus.shop_clicked.emit()
