extends Node2D

@onready var interactionArea = $interactionArea
@onready var player = get_tree().get_first_node_in_group("player")
@export var enemyScene:PackedScene
signal playCutscene
# Called when the node enters the scene tree for the first time.
func _ready():
	interactionArea.interact = Callable(self, "_on_interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_interact():
	#print(player)
	#print("PLAY CUTSCENE")
	playCutscene.emit()
	var enemy = enemyScene.instantiate()
	get_node("/root/WorldRoot/Level 1/Enemies").add_child(enemy)
	enemy.targetNode = get_tree().get_first_node_in_group("player")
	enemy.global_position = global_position
	enemy.rotation = 0
	enemy.canMove = false
	enemy.add_to_group("enemies")
	enemy.find_child("audioPlayer").queue_free()
	player.updateEnemyList()
	queue_free()
	
