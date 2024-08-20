extends Label

func _process(delta: float) -> void:
	self.text = str(Points.points) + "/30"
