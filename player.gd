extends KinematicBody2D


const UP = Vector2(0,-1)
const JUMP = 400
const GRAVITY = 20
const MAXSPEED = 150
const ACCEL = 10
var doublesaut = true
var regard_droite = true
var movement = Vector2()
puppet var p_position = Vector2(0, 0) setget p_position_set
puppet var p_movement = Vector2()
puppet var p_animation = Sprite
onready var tween=$Tween

func _ready():	
	yield(get_tree(), "idle_frame")
	if get_tree().has_network_peer():
		if is_network_master():
			Global.Joueur_controle = self

func _physics_process(delta)->void:
	
	if is_network_master():
		movement.y += GRAVITY
		movement.x = clamp(movement.x, -MAXSPEED, MAXSPEED)
		if !doublesaut && is_on_floor():
			doublesaut = true
			
		if regard_droite == true:
			rpc_unreliable("update_animation_scale1", Animation)
			$Animation.scale.x=1
		else:
			rpc_unreliable("update_animation_scale_1", Animation)
			$Animation.scale.x=-1
			 
		if Input.is_action_pressed("right"):
			movement.x = MAXSPEED
			regard_droite = true
			rpc_unreliable("update_animation_RunR", Animation)
			$Animation.play("RunR")
		elif Input.is_action_pressed("left"):
			movement.x = -MAXSPEED
			regard_droite = false
			rpc_unreliable("update_animation_RunR", Animation)
			$Animation.play("RunR")
		else: 
			movement.x = lerp(movement.x, 0, 0.2)
			rpc_unreliable("update_animation_Idle", Animation)
			$Animation.play("Idle")
			
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				movement.y = -JUMP
		elif doublesaut:
			if Input.is_action_just_pressed("jump"):
				movement.y = -JUMP
				doublesaut = false
				
		if movement.y < 19 :
			rpc_unreliable("update_animation_jump", Animation)
			$Animation.play("JumpR")
		elif movement.y > 20:
			rpc_unreliable("update_animation_fall", Animation)
			$Animation.play("Fall")
			
		movement = move_and_slide(movement, UP)
	else:
		
		if not tween.is_active():
			move_and_slide(p_movement * MAXSPEED )


remote func update_animation_RunL(animation):
	$Animation.play("RunL")
remote func update_animation_RunR(animation):
	$Animation.play("RunR")
remote func update_animation_Idle(animation):
	$Animation.play("Idle")
remote func update_animation_jump(animation):
	$Animation.play("JumpR")
remote func update_animation_fall(animation):
	$Animation.play("Fall")
remote func update_animation_scale1(animation):
	$Animation.scale.x=1
remote func update_animation_scale_1(animation):
	$Animation.scale.x=-1

sync func update_position(new):
	global_position = new
	p_position = new

func p_position_set(new)->void:
	p_position=new
	tween.interpolate_property(self, "global_position", global_position, p_position, 0.1)
	tween.start()

func _on_temps_de_rafraichissement_reseau_timeout():
	#if get_tree().has_network_peer():
	if is_network_master():
		
		rset_unreliable("p_position", global_position)
		rset_unreliable("p_movement", movement)
		rset_unreliable("p_animation", $Animation.frame)
			
func _exit_tree() -> void:
	#Global.alive_players.erase(self)
	if get_tree().has_network_peer():
		if is_network_master():
			Global.Joueur_controle = null
