extends Node

func _ready() -> void:
	SignalBus.spawn_monkey.connect(_on_spawn_monkey)
	#TODO DELETE THIS
	Bananas.bananas = 500
	
func _on_spawn_monkey():
	var monkeyscene = load("res://monkey/monkey.tscn")
	var monkey = monkeyscene.instantiate()
	monkey.position.x = 200
	monkey.position.y = 200
	add_child(monkey)
