extends Node2D

var fading = false

func _process(delta):
	if(fading):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Wing Flaps"), move_toward(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Wing Flaps")), -80, delta*8))

func fade_audio():
	fading = true
