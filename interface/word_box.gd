extends CharacterBody2D

# This code is stolen from a YouTube video:
# https://www.youtube.com/watch?v=GfGpXfbLVBA
# https://gist.github.com/erdavids/bc303766260aa80ec58739ab8e914f57

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

var mouse_in = false

func _ready():
	pass
	
	
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
