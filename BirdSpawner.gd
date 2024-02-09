extends Node2D

@export var birdScene:PackedScene

func _on_timer_timeout():
	var bird = birdScene.instantiate()
	bird.global_position = global_position
	add_child(bird)
	bird.position.x += randf_range(-100, 100)
	
