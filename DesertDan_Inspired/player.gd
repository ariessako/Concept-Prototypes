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
const MAX_VEL = 300
const ACCEL = 10
const DECCEL = 20
var vel = Vector2()


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process( delta ):
	# player input
	if btn_left.check() == 2:
		vel.x = lerp( vel.x, -MAX_VEL, ACCEL * delta )
	elif btn_right.check() == 2:
		vel.x = lerp( vel.x, MAX_VEL, ACCEL * delta )
	else:
		if abs( vel.x ) > 2:
			vel.x = lerp( vel.x, 0, DECCEL * delta )
	if btn_up.check() == 2:
		vel.y = lerp( vel.y, -MAX_VEL, ACCEL * delta )
	elif btn_down.check() == 2:
		vel.y = lerp( vel.y, MAX_VEL, ACCEL * delta )
	else:
		if abs( vel.y ) > 2:
			vel.y = lerp( vel.y, 0, ACCEL * delta )
		else:
			vel.y = 0

	move_and_slide( vel )
