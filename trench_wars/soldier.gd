extends KinematicBody2D

#----------------------------------------
# player input
#----------------------------------------
var input_states = preload( "res://input_states.gd" )
var btn_left = input_states.new( "btn_left" )
var btn_right = input_states.new( "btn_right" )
var btn_up = input_states.new( "btn_up" )
var btn_down = input_states.new( "btn_down" )

#----------------------------------------
# motion
#----------------------------------------
const MAX_VEL = 400
const ACCEL = 10
const DECCEL = 30
var vel = Vector2()



#----------------------------------------
# direction
#----------------------------------------
onready var rotate = $rotate
var dir_cur = 1
var dir_nxt = 1
var dir_timer = 0

#----------------------------------------
# animation
#----------------------------------------
onready var anim = $anim
var anim_cur = ""
var anim_nxt = "idle"
var anim_spd = 1


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# player input
	var _is_running = false
	if btn_left.check() == 2:
		if vel.x <= 0:
			vel.x = lerp( vel.x, -MAX_VEL, ACCEL * delta )
		else:
			vel.x = lerp( vel.x, -MAX_VEL, DECCEL * delta )
		_is_running = true
		dir_nxt = -1
	elif btn_right.check() == 2:
		vel.x = lerp( vel.x, MAX_VEL, ACCEL * delta )
		_is_running = true
		dir_nxt = 1
	else:
		vel.x = lerp( vel.x, 0, DECCEL * delta )
		if abs( vel.x ) < 2: vel.x = 0
		anim_nxt = "idle"
		anim_spd = 1
		dir_timer = 0
	
	if _is_running:
		anim_nxt = "run"
		if dir_nxt != dir_cur:
			dir_timer = 0
		else:
			dir_timer += delta
		anim_spd = ( min( dir_timer, 2 ) / 2 ) * 2
	
	vel = move_and_slide( vel )
	
	# direction
	if dir_nxt != dir_cur:
		dir_cur = dir_nxt
		rotate.scale = Vector2( dir_cur, 1 )
	
	# animation
	if anim_nxt != anim_cur:
		anim_cur = anim_nxt
		anim.play( anim_cur )
	#anim.set_speed_scale( anim_spd )


























