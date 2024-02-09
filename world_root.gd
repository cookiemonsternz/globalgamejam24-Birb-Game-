extends Node2D

@export var Level1:PackedScene
@export var Cutscene:PackedScene
@export var Cutscene2:PackedScene
@export var mainMenu:PackedScene
func _ready():
	var menu = mainMenu.instantiate()
	add_child(menu)
	menu.startPressed.connect(start_pressed)
	menu.quitPressed.connect(quit_pressed)
	

func start_pressed():
	get_child(0).queue_free()
	var level = Level1.instantiate()
	add_child(level)
	level.get_node('Enemies/First Collectable Bird').playCutscene.connect(play_cutscene)
	level.get_node('Environment/Vine').playCutscene2.connect(play_cutscene_2)
	level.get_node('Player/Player2/PauseMenu').menuButtonPressed.connect(menu_pressed)

func menu_pressed():
	get_child(0).queue_free()
	var menu = mainMenu.instantiate()
	add_child(menu)
	menu.startPressed.connect(start_pressed)
	menu.quitPressed.connect(quit_pressed)

func quit_pressed():
	get_tree().quit()

func play_cutscene():
	get_tree().get_first_node_in_group("player").canMove = false
	get_child(0).hide()
	var cutsceneInstance = Cutscene.instantiate()
	add_child(cutsceneInstance)
	get_tree().get_first_node_in_group("camera1").enabled = false
	get_tree().get_first_node_in_group("camera2").enabled = true
	get_tree().get_first_node_in_group("animPlayer").animation_finished.connect(anim_finished)
	
func play_cutscene_2():
	get_tree().get_first_node_in_group("player").canMove = false
	get_child(0).hide()
	var cutsceneInstance2 = Cutscene2.instantiate()
	add_child(cutsceneInstance2)
	get_tree().get_first_node_in_group("camera1").enabled = false
	get_tree().get_first_node_in_group("camera3").enabled = true
	get_tree().get_first_node_in_group("animPlayer2").animation_finished.connect(anim_finished2)

func anim_finished(_anim):
	get_tree().get_first_node_in_group("player").canMove = true
	get_child(0).show()
	get_child(1).queue_free()
	get_tree().get_first_node_in_group("camera1").enabled = true
	get_tree().get_first_node_in_group("enemies").canMove = true

func anim_finished2(_anim):
	print("anim finished")
	get_child(0).queue_free()
	get_child(1).queue_free()
	var menu = mainMenu.instantiate()
	add_child(menu)
	menu.startPressed.connect(start_pressed)
	menu.quitPressed.connect(quit_pressed)
