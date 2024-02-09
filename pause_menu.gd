extends Control

signal menuButtonPressed
signal resumeButtonPressed
func  _ready():
	$Options.find_child("VBoxContainer2").backButtonPressed.connect(_on_back_button_pressed)

func _on_resume_button_pressed():
	$PauseMenu.hide()
	$Options.hide()
	resumeButtonPressed.emit()
	


func _on_options_button_pressed():
	$PauseMenu.hide()
	$Options.show()


func _on_menu_button_pressed():
	menuButtonPressed.emit()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	$Options.hide()
	$PauseMenu.show()
