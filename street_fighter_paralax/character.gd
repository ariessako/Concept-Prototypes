extends KinematicBody2D
const MAX_VEL = 70
var vel = Vector2( 0, 0 )
var anim_nxt = "idle"
var anim_cur = ""
var is_jump = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	vel.y += 1000 * delta # gravity
	vel = move_and_slide( vel, Vector2( 0, -1 ) )
	
	if is_on_floor():
		if Input.is_action_pressed( "ui_left" ):
			vel.x = -MAX_VEL
			anim_nxt = "run_backward"
		elif Input.is_action_pressed( "ui_right" ):
			vel.x = MAX_VEL
			anim_nxt = "run_forward"
		else:
			vel.x = 0
			anim_nxt = "idle"
		if Input.is_action_just_pressed( "ui_up" ):
			vel.y = -400
	else:
		if Input.is_action_pressed( "ui_left" ):
			vel.x = -MAX_VEL
		elif Input.is_action_pressed( "ui_right" ):
			vel.x = MAX_VEL
		else:
			vel.x = 0
			anim_nxt = "idle"
		if vel.y < 0:
			anim_nxt = "jump"
		else:
			anim_nxt = "fall"
	

	if anim_nxt != anim_cur:
		anim_cur = anim_nxt
		$anim.play( anim_cur )
		
