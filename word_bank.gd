extends Area2D

const size = Vector2(160, 280)
@onready var collider = $WordBankCollider
@onready var WordBoxHolder = preload("res://word_box_holder.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Make the collider the right size, in the right place.
	var position = Vector2(
		size.x / 2,
		size.y / 2
	)
	collider.set_position(position)
	
	var collider_shape = RectangleShape2D.new()
	collider_shape.size = size
	
	collider.set_shape(collider_shape)
	
	$FlowContainer.size = size
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_line_edit_new_word_typed(word: String) -> void:
	
	var new_word_container = WordBoxHolder.instantiate()
	new_word_container.create(word)
	$FlowContainer.add_child(new_word_container)
	
