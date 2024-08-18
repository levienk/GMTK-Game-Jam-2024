extends CharacterBody2D

# This code is stolen from a YouTube video:
# https://www.youtube.com/watch?v=GfGpXfbLVBA
# https://gist.github.com/erdavids/bc303766260aa80ec58739ab8e914f57

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

var mouse_in = false

@onready var collider = $WordBoxCollider

func _ready():
	
	# Anchor the collider in the center
	
	var position = Vector2(
		$TextBoundary.size.x / 2,
		$TextBoundary.size.y / 2
	)
	collider.set_position(position)
	
	# Size the collider to fit the text
	var size = Vector2(
		$TextBoundary.size.x - 16,
		$TextBoundary.size.y - 16
	)
	
	var collider_shape = RectangleShape2D.new()
	collider_shape.size = size
	
	collider.set_shape(collider_shape)
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta):
	if dragging:
		velocity = (newPosition - position) * Vector2(30, 30)
		move_and_slide()
	
func _on_text_boundary_mouse_entered() -> void:
	mouse_in = true


func _on_text_boundary_mouse_exited() -> void:
	mouse_in = false

func set_text(text: String) -> void:
	
	$TextBoundary/Label.text = text
	
	# Yes, both calls are required to update it...
	$TextBoundary._ready()
	$TextBoundary._ready()
	_ready()
	
	
