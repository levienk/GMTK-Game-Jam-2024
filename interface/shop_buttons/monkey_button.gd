extends TextureButton

@onready var price_label: Label = $Price
@export var price = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price_label.text = str(price)

func _pressed() -> void:
	if Bananas.subtract_score(price):
		SignalBus.spawn_monkey.emit()
