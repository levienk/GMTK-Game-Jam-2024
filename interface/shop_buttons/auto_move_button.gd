extends TextureButton

@onready var price_label: Label = $Price
@onready var description_label: Label = $Description

@export var price = 3000
@export var level_2_price = 7000
var level = 1

@onready var ka_ching = $BuySFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price_label.text = str(price)

func _pressed() -> void:
	if Bananas.subtract_score(price) and level == 1:
		ka_ching.play()
		SignalBus.auto_1_enabled.emit()
		level += 1
		level_up()
	elif Bananas.subtract_score(price) and level == 2:
		ka_ching.play()
		SignalBus.auto_2_enabled.emit()
		modulate.a = .5
		disabled = true

func level_up():
	texture_normal = load("res://assets/art/sprites/Auto_2.png")
	texture_hover = load("res://assets/art/sprites/Auto_2hover.png")
	price = level_2_price
	price_label.text = str(price)
	description_label.text = "Auto 2"
	$ShortDescription.text = "Spellseeker-and-destroyer"
	$LongDescription.text = "Unfortunately the machine uprising has rendered the need for flesh-creature literature a moot point. Luckily for us, though, they're still willing to make sure all our adjectives are properly ordered.\n\nAutomate quote completion"
	$TextureRect2.texture = load("res://assets/art/sprites/tooltip6.png")
	
func _on_mouse_entered() -> void:
	$Timer.start()

func _on_mouse_exited() -> void:
	$TextureRect2.visible = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	$TextureRect2.visible = true
