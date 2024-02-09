extends Area2D

signal killboxTriggered

func _on_body_entered(body):
	if(body == get_tree().get_first_node_in_group("player")):
		killboxTriggered.emit()
