extends Sprite2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animPlayer = $AnimationPlayer
func _on_area_2d_body_entered(body):
	if(body == player):
		animPlayer.play("BranchFall")
