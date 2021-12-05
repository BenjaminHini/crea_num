extends KinematicBody2D


const UP = Vector2(0,-1)
const JUMP = 400
const GRAVITY = 20
const MAXSPEED = 150
const ACCEL = 10
var doublesaut = true
var regard_droite = true
var movement = Vector2()


func _physics_process(delta):

	movement.y += GRAVITY
	movement.x = clamp(movement.x, -MAXSPEED, MAXSPEED)
	if !doublesaut && is_on_floor():
		doublesaut = true
		
	if regard_droite == true:
		$AnimatedSprite.scale.x=1
	else:
		$AnimatedSprite.scale.x=-1
		 
	if Input.is_action_pressed("right"):
		movement.x = MAXSPEED
		regard_droite = true
		$AnimatedSprite.play("RunR")
	elif Input.is_action_pressed("left"):
		movement.x = -MAXSPEED
		regard_droite = false
		$AnimatedSprite.play("RunR")
	else: 
		movement.x = lerp(movement.x, 0, 0.2)
<<<<<<< HEAD
		$AnimatedSprite.play("Idle")

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y = -JUMP
	elif doublesaut:
=======
	
	if is_on_floor():
>>>>>>> a1218ed6f2052c25f91423c58fd1d97febc07320
		if Input.is_action_just_pressed("jump"):
			movement.y = -JUMP
			doublesaut = false
	if movement.y <0 :
		$AnimatedSprite.play("JumpR")
	elif movement.y <0:
		$AnimatedSprite.play("Fall")

	print(is_on_floor())
	movement = move_and_slide(movement, UP)
