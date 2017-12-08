extends KinematicBody2D
onready var global = get_node( "/root/global" )


#-------------------------------------------
# player input
#-------------------------------------------
export(int) var playerno = 1
var playernm = ""
var input_states
var btn_up
var btn_down

# Motion
var velocity = 0
const acceleration = 25
const max_velocity = 250

# ball position buffer
var bb = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
var bbpos = 0
var bbsum = 0
var bblen = 0

func _ready():
	input_states = preload( "res://scripts/input_states.gd" )
	if playerno == 1:
		playernm = "player_1"
		btn_up = input_states.new( "p1_btn_up" )
		btn_down = input_states.new( "p1_btn_down" )
	else:
		playernm = "player_2"
		btn_up = input_states.new( "p2_btn_up" )
		btn_down = input_states.new( "p2_btn_down" )
	bblen = bb.size()
	set_fixed_process( true )


func _fixed_process( delta ):
	if global.gamestate[playernm]["type"] == "human":
		# Player input
		if btn_up.check() == 2:
			velocity = lerp( velocity, -max_velocity, acceleration * delta )
		elif btn_down.check() == 2:
			velocity = lerp( velocity, max_velocity, acceleration * delta )
		else:
			velocity = lerp( velocity, 0, acceleration * delta )
	else:
		if not get_parent().ball:
			return
		var ball_pos = get_parent().ball.get_pos()
		var direction = sign( ball_pos.y - get_pos().y )
		if direction > 0:
			velocity = lerp( velocity, max_velocity, acceleration * delta )
		elif direction < 0:
			velocity = lerp( velocity, -max_velocity, acceleration * delta )
		else:
			velocity = lerp( velocity, 0, acceleration * delta )
	if get_pos().y < 16:
		set_pos( Vector2( get_pos().x, 16 ) )
		velocity = 0
	elif get_pos().y > 584:
		set_pos( Vector2( get_pos().x, 584 ) )
	else:
		var m = Vector2( 0, velocity * delta )
		move( m )
	
