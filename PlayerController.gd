extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var coyoteTimeCounter = 0
const COYOTETIME = 0.2 #secs
var doubleJumpCounter:int = 0
const DOUBLEJUMP:int = 1 #total of two jumps
const DASHDURATION:float = 0.2 #secs
var isDashing = false
var canDash = false
var dashCounter = 0.0
const DASHSPEED = 800.0
var dashDir = 0
var jumping = false
var paused = false
@export var canMove = true
var moveMod = 0.0
@onready var respawnHandler = get_tree().get_first_node_in_group("respawnHandler")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animSprite = $"Main Sprite"

func _ready():
	var killboxes = get_tree().get_nodes_in_group("killbox")
	for killbox in killboxes:
		killbox.killboxTriggered.connect(respawn)
	$PauseMenu.resumeButtonPressed.connect(pause)

func _physics_process(delta):
	if(canMove):
		updateJumpVariables(delta)
		jump()
		#dash(delta)
		move(delta)
	doAnims()
	if Input.is_action_just_pressed("pause"):
		pause()

func updateJumpVariables(delta):
	if(is_on_floor()):
		coyoteTimeCounter = COYOTETIME
		doubleJumpCounter = 0 #reset jumps when on floor
		moveMod = 0
		if(jumping):
			jumping = false
			$JumpLand.play()
	else:
		if(coyoteTimeCounter >= 0):
			coyoteTimeCounter -= delta #decrement coyote time every frame by delta
		elif(doubleJumpCounter == 0):
			doubleJumpCounter+=1 #prevents you being able to do three jumps with coyote time
		moveMod = move_toward(moveMod, 0.0, delta)
	
func pause():
	if(paused):
		print(paused)
		$PauseMenu.get_child(0).hide()
		$PauseMenu.get_child(1).hide()
		paused = false
		canMove = true
		var enemies = get_tree().get_nodes_in_group("enemy")
		for enemy in enemies:
			enemy.canMove = true
	elif(!paused):
		print(paused)
		canMove = false
		paused = true
		$PauseMenu.get_child(1).show()
		var enemies = get_tree().get_nodes_in_group("enemy")
		for enemy in enemies:
			enemy.canMove = false


func jump():
	if Input.is_action_just_pressed("jump") and (coyoteTimeCounter > 0.0 or doubleJumpCounter < DOUBLEJUMP):
		velocity.y = JUMP_VELOCITY
		coyoteTimeCounter = 0.0
		doubleJumpCounter += 1
		$Jump.play(0.02)
		jumping = true
	if Input.is_action_just_released("jump") and velocity.y < 1:
		velocity.y = 0
		
func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if isDashing:
			velocity.x = dashDir * DASHSPEED
		else:
			velocity.x = (direction * SPEED) + moveMod
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) + moveMod

	move_and_slide()

func dash(delta):
	if(canDash && !isDashing && Input.is_action_just_pressed("dash") && Input.get_axis("move_left", "move_right")):
		isDashing = true
		canDash = false
		dashCounter = DASHDURATION
		dashDir = Input.get_axis("move_left", "move_right")
	if(isDashing):
		dashCounter -= delta
	if(dashCounter <= 0):
		isDashing = false
	if(!isDashing && is_on_floor()):
		canDash = true
		
func _on_touched_enemy_jump_box():
	velocity.y = - 500
	moveMod += randf_range(-100, 100)
	doubleJumpCounter -= 1

func updateEnemyList():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.touchedEnemyJumpBox.connect(_on_touched_enemy_jump_box)

func respawn():
	if(respawnHandler.currentSpawnPointNum == 1):
		global_position = $"/root/WorldRoot/Level 1/Environment/respawnPoints/SpawnPoint1".global_position
	if(respawnHandler.currentSpawnPointNum == 2):
		global_position = $"/root/WorldRoot/Level 1/Environment/respawnPoints/SpawnPoint2".global_position
	if(respawnHandler.currentSpawnPointNum == 3):
		global_position = $"/root/WorldRoot/Level 1/Environment/respawnPoints/SpawnPoint3".global_position
	if(respawnHandler.currentSpawnPointNum == 4):
		global_position = $"/root/WorldRoot/Level 1/Environment/respawnPoints/SpawnPoint4".global_position
	if(respawnHandler.currentSpawnPointNum == 5):
		global_position = $"/root/WorldRoot/Level 1/Environment/respawnPoints/SpawnPoint5".global_position

func doAnims():
	if(velocity.x > 0):
			animSprite.flip_h = true
	elif(velocity.x < 0):
			animSprite.flip_h = false
	if(velocity.x != 0 && is_on_floor()):
		animSprite.play("Walk")
	if(velocity.x == 0 && is_on_floor()):
		animSprite.play("Idle")
	if(!is_on_floor() && animSprite.animation != 'JumpLoop'):
		animSprite.animation = 'JumpStart'


func _on_main_sprite_animation_finished():
	if(animSprite.animation == 'JumpStart'):
		animSprite.play("JumpLoop")
