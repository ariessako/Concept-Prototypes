extends KinematicBody2D

const MAX_VEL = 100
const ACCEL = 10
var vel = Vector2()
var dir_cur = 1
var dir_nxt = 1
var anim_cur = ""
var anim_nxt = "idle"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process( delta ):
	var _is_moving = false
	if Input.is_action_pressed( "btn_left" ):
		dir_nxt = -1
		vel.x = lerp( vel.x, -MAX_VEL, ACCEL * delta )
		_is_moving = true
	elif Input.is_action_pressed( "btn_right" ):
		dir_nxt = 1
		vel.x = lerp( vel.x, MAX_VEL, 5 * ACCEL * delta )
		_is_moving = true
	else:
		vel.x = lerp( vel.x, 0, ACCEL * delta )
	if Input.is_action_pressed( "btn_up" ):
		vel.y = lerp( vel.y, -MAX_VEL, ACCEL * delta )
		_is_moving = true
	elif Input.is_action_pressed( "btn_down" ):
		vel.y = lerp( vel.y, MAX_VEL, ACCEL * delta )
		_is_moving = true
	else:
		vel.y = lerp( vel.y, 0, 5 * ACCEL * delta )
	if _is_moving:
		anim_nxt = "run"
	else:
		anim_nxt = "idle"
	
	vel = vel.clamped( MAX_VEL )
	vel = move_and_slide( vel )
	
	if dir_nxt != dir_cur:
		dir_cur = dir_nxt
		$rotate.scale.x = dir_cur
	if anim_nxt != anim_cur:
		anim_cur = anim_nxt
		$anim.play( anim_cur )
	