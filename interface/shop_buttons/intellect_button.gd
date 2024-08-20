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

func _pressed() -> void:
	if Bananas.subtract_score(price) and level == 1:
		ka_ching.play()
		SignalBus.intellect_1_enabled.emit()
		level += 1
		level_up()
	elif Bananas.subtract_score(price) and level == 2:
		ka_ching.play()
		SignalBus.intellect_2_enabled.emit()
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Smart_2.png")
	texture_hover = load("res://assets/art/sprites/Smart_2hover.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Intellect 2"
	$ShortDescription.text = "Pocket Scrabble dictionary"
	$LongDescription.text = "Of course \"wppwrmwste\" is a word! It says so right here! Through the power of the Scrabble dictionary, even the most profound pile of phonics can become a valid play.\n\n4x word chance"
	$TextureRect2.texture = load("res://assets/art/sprites/tooltip4.png")

func _on_mouse_entered() -> void:
	$Timer.start()

func _on_mouse_exited() -> void:
	$TextureRect2.visible = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	$TextureRect2.visible = true
