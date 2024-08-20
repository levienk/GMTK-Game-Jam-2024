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


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
