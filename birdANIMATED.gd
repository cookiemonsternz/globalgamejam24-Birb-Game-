extends AnimatedSprite2D

@export var angle = 0.2
@export var speed = 10
@onready var moveAngle = randf_range(-angle, angle)

func _physics_process(_delta):
	var direction = Vector2(moveAngle, -1)
	position += direction * speed
	if(position.y < -1000):
		queue_free()
