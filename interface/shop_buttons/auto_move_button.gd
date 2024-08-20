extends TextureButton

@onready var price_label: Label = $Price
@onready var description_label: Label = $Description

@export var price = 5000
@export var level_2_price = 7000
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bananas.bananas = 700000
	price_label.text = str(price)

func _pressed() -> void:
	if Bananas.subtract_score(price) and level == 1:
		SignalBus.auto_1_enabled.emit()
		level += 1
		level_up()
	elif Bananas.subtract_score(price) and level == 2:
		SignalBus.auto_2_enabled.emit()
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Auto_2.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Auto 2"
