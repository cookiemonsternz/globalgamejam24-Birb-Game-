extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
const SPEED = 180
const HITSPEED = 950
@export var targetNode:Node2D
signal touchedEnemyJumpBox
var justHitCounter = 0.0
const HITTIME = 0.7
var canMove = true
@onready var moveBias = Vector2(randf_range(-0.5,0.5), randf_range(-0.5,0.5))

func _physics_process(delta):
	if(justHitCounter <= 0):
		var direction = global_position.direction_to(targetNode.global_position).normalized() + moveBias
		velocity = direction * SPEED * (global_position.distance_to(targetNode.global_position)/160)
	else:
		var reverseDirection = player.global_position.direction_to(global_position) * Vector2.DOWN
		velocity = reverseDirection * HITSPEED
	if(velocity.x > 0):
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	if(canMove):
		move_and_slide()
	doVars(delta)

func doVars(delta):
	if(justHitCounter > 0):
		justHitCounter -= delta

func _on_jump_area_body_entered(body):
	if body == player:
		touchedEnemyJumpBox.emit()
		justHitCounter = HITTIME
