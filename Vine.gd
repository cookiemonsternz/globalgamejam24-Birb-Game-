extends TileMap
signal playCutscene2
@onready var interactionArea = $interactionArea
@onready var player = get_tree().get_first_node_in_group("player")
func _ready():
	interactionArea.interact = Callable(self, "_on_interact")

func _on_interact():
	print("Play Cutscene 2")
	playCutscene2.emit()
