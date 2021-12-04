extends KinematicBody2D

const UP = Vector2(0,-1)
const JUMP = 50
const GRAVITY = 20
const MAXSPEED = 50
const ACCEL = 10



var movemement = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics(delta):
	
	movemement.y += GRAVITY
	
	movemement.x = clamp(movemement.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("right"):
		movemement.x = MAXSPEED
	elif Input.is_action_pressed("left"):
		movemement.x = -MAXSPEED
	else:
		movemement.x = lerp(movemement.x, 0, 0.2)
		
	if is_on_floor():
		if Input.is_action_pressed("space"):
			movemement.y = -JUMP

	movemement = move_and_slide(movemement, UP)
