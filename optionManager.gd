extends VBoxContainer

signal backButtonPressed

func _ready():
	$GridContainer/MasterSlider.value = AudioServer.get_bus_volume_db(0)
	$GridContainer/MusicSlider.value = AudioServer.get_bus_volume_db(1)
	$GridContainer/SFXSlider.value = AudioServer.get_bus_volume_db(2)

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	#print(AudioServer.get_bus_volume_db(0))


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	#print(AudioServer.get_bus_volume_db(1))


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Cutscene"), value)
	#print(AudioServer.get_bus_volume_db(2))


func _on_display_mode_dropdown_item_selected(index):
	if(index == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if(index == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if(index == 2):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_vsync_dropdown_item_selected(index):
	if(index == 0):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	if(index == 1):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	if(index == 2):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_back_button_pressed():
	backButtonPressed.emit()
