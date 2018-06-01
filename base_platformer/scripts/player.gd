extends KinematicBody2D

enum STATES { IDLE, RUN, JUMP, WALL }
var state_cur = -1
var state_nxt = STATES.IDLE

#---------------------------------------
# player input
#---------------------------------------
var input_states = preload( "res://scripts/input_states.gd" )
var btn_left = input_states.new( "btn_left" )
var btn_right = input_states.new( "btn_right" )
var btn_up = input_states.new( "btn_up" )
var btn_fire = input_states.new( "btn_fire" )

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func physics_process(delta):
	state_cur = state_nxt
	
	if state_cur == STATES.IDLE:
		_state_idle( delta )
	elif state_cur == STATES.RUN:
		_state_run( delta )
	elif state_cur == STATES.JUMP:
		_state_jump( delta )
	elif state_cur == STATES.WALL:
		_state_wall( delta )


func _state_idle( delta ):
	pass

func _state_run( delta ):
	pass

func _state_jump( delta ):
	pass

func _state_wall( delta ):
	pass
