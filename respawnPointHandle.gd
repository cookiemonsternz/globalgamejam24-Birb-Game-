extends Node2D

var currentSpawnPointNum = 0
func _on_area_2d_body_entered(body, num):
	if body == get_tree().get_first_node_in_group("player"):
		if num > currentSpawnPointNum:
			currentSpawnPointNum = num
			#print(currentSpawnPointNum)
