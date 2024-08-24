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
	if level == 1 and Bananas.subtract_score(price):
		ka_ching.play()
		SignalBus.speed_1_enabled.emit()
		level = 2
		level_up()
	elif level == 2 and Bananas.subtract_score(price):
		ka_ching.play()
		SignalBus.speed_2_enabled.emit()
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Speed_2.png")
	texture_hover = load("res://assets/art/sprites/Speed_2hover.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Speed 2"
	$ShortDescription.text = "Lithium-ion batteries"
	$LongDescription.text = "Some of the finest batteries modern engineering can produce, thrown haphazardly into the mechanical machinations of some monkeys with typewriters. Wouldn't Edison be proud?\n\n3x monkey typing speed (2x valid word decay speed)"
	$TextureRect2.texture = load("res://assets/art/sprites/tooltip2.png")

func _on_mouse_entered() -> void:
	$Timer.start()

func _on_mouse_exited() -> void:
	$TextureRect2.visible = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	$TextureRect2.visible = true
