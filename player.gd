extends KinematicBody2D


const UP = Vector2(0,-1)
const JUMP = 400
const GRAVITY = 20
const MAXSPEED = 150
const ACCEL = 10
var doublesaut = true
var movement = Vector2()


func _physics_process(delta):
<<<<<<< Updated upstream
	movement.y += GRAVITY
	
=======
	
	movement.y += GRAVITY
>>>>>>> Stashed changes
	movement.x = clamp(movement.x, -MAXSPEED, MAXSPEED)
	if !doublesaut && is_on_floor():
		doublesaut = true

	if Input.is_action_pressed("right"):
		movement.x = MAXSPEED
	elif Input.is_action_pressed("left"):
		movement.x = -MAXSPEED
	else: 
		movement.x = lerp(movement.x, 0, 0.2)
	
<<<<<<< Updated upstream
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
=======
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y = -JUMP
	elif doublesaut:
		if Input.is_action_just_pressed("jump"):
			movement.y = -JUMP
			doublesaut = false
		
	
	print(is_on_floor())
	movement = move_and_slide(movement, UP)
>>>>>>> Stashed changes
