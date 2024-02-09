extends Control

signal startPressed
signal quitPressed

func _on_start_button_pressed():
	startPressed.emit()

func _ready():
	get_node("Options/HBoxContainer/VBoxContainer2").backButtonPressed.connect(_on_back_button_pressed)

func _on_options_button_pressed():
	$Options.show()
	$"Main Screen".hide()

func _on_back_button_pressed():
	$Options.hide()
	$"Main Screen".show()

func _on_quit_button_pressed():
	quitPressed.emit()
