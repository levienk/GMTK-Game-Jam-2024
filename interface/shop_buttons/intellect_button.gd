extends TextureButton

@onready var price_label: Label = $Price
@onready var description_label: Label = $Description

@export var price = 500
@export var level_2_price = 3000
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price_label.text = str(price)
	tooltip_text = "2x word chance"

func _pressed() -> void:
	if Bananas.subtract_score(price) and level == 1:
		Monkey.valid_word_chance *= 2
		Monkey.valid_word_in_quote_chance *= 2
		level += 1
		level_up()
	elif Bananas.subtract_score(price) and level == 2:
		Monkey.valid_word_chance *= 2
		Monkey.valid_word_in_quote_chance *= 2
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Smart_2.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Intellect 2"
	tooltip_text = "4x word chance"
