extends TextureButton

@onready var price_label: Label = $Price
@onready var description_label: Label = $Description

@export var price = 500
@export var level_2_price = 3000
var level = 1

@onready var ka_ching = $BuySFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price_label.text = str(price)
	tooltip_text = "2x monkey typing speed"

func _pressed() -> void:
	if Bananas.subtract_score(price) and level == 1:
		ka_ching.play()
		SignalBus.speed_1_enabled.emit()
		level += 1
		level_up()
	elif Bananas.subtract_score(price) and level == 2:
		ka_ching.play()
		SignalBus.speed_2_enabled.emit()
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Speed_2.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Speed 2"
	tooltip_text = "4x monkey typing speed (2x valid word speed)"
