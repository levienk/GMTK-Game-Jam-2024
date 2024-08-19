extends Node

var monkeyscene = load("res://monkey/monkey.tscn")
var pos = Vector2(200,280) # Bottom Left

func _ready() -> void:
	SignalBus.spawn_monkey.connect(_on_spawn_monkey)
	
# From SignalBus MonkeyButton
func _on_spawn_monkey():
	var monkey = monkeyscene.instantiate()
	monkey.position = pos
	
	if pos.x >= 550:
		pos.y -= 30
		pos.x = 200
	else:
		pos.x += 50
	add_child(monkey)
