extends AudioStreamPlayer

@onready var tempAudio1 = AudioServer.get_bus_volume_db(1)
@onready var tempAudio2 = AudioServer.get_bus_volume_db(2)
var decreasing = false
var increasing = false
func _stop_audio():
	decreasing = true
	increasing = false

func _process(_delta):
	if(decreasing and AudioServer.get_bus_volume_db(0) > -69):
		AudioServer.set_bus_volume_db(1, move_toward(AudioServer.get_bus_volume_db(1), -70, 0.5))
		AudioServer.set_bus_volume_db(2, move_toward(AudioServer.get_bus_volume_db(2), -70, 0.5))
	if(AudioServer.get_bus_volume_db(0) < -69):
		decreasing = false
	#if(increasing and AudioServer.get_bus_volume_db(1) < tempAudio1):
		#print("increasing")
		#AudioServer.set_bus_volume_db(1, move_toward(AudioServer.get_bus_volume_db(1), tempAudio1, 4))
		#AudioServer.set_bus_volume_db(2, move_toward(AudioServer.get_bus_volume_db(2), tempAudio2, 4))
		#AudioServer.set_bus_volume_db(4, move_toward(AudioServer.get_bus_volume_db(4), 0, 4))
	#if(AudioServer.get_bus_volume_db(0) > tempAudio1):
		#increasing = false
		

func _start_audio():
	decreasing = false
	AudioServer.set_bus_volume_db(1, tempAudio1)
	AudioServer.set_bus_volume_db(2, tempAudio2)
	AudioServer.set_bus_volume_db(4, 0)
