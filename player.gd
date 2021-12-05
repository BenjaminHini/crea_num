extends KinematicBody2D


const UP = Vector2(0,-1)
const JUMP = 400
const GRAVITY = 20
const MAXSPEED = 150
const ACCEL = 10

var movement = Vector2()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
<<<<<<< Updated upstream
	movement.y += GRAVITY
	
=======
	
	movement.y += GRAVITY
>>>>>>> Stashed changes
	movement.x = clamp(movement.x, -MAXSPEED, MAXSPEED)

	if Input.is_action_pressed("right"):
		movement.x = MAXSPEED
	elif Input.is_action_pressed("left"):
		movement.x = -MAXSPEED
	else: 
		movement.x = lerp(movement.x, 0, 0.2)
	
<<<<<<< Updated upstream
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			movement.y = -JUMP
			
	#motion = move_and_slide(motion, UP)
=======
	#if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y = -JUMP
			
	move_and_slide(movement)
>>>>>>> Stashed changes
