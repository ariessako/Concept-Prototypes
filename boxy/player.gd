extends KinematicBody2D
var input_states = preload( "res://input_states.gd" )
var btn_left = input_states.new( "btn_left" )
var btn_right = input_states.new( "btn_right" )
var btn_jump = input_states.new( "btn_jump" )


enum STATES { AIR, GROUND }
const MAX_VEL = 60
const MAX_VEL_AIR = 60
const ACCEL = 10
const ACCEL_AIR = 5
const GRAV = 200
const TERM_VEL = 100
const JUMP_SPEED = 90
var vel = Vector2()
var _is_jump = false
var _air_time = 0
var _on_door = false

var state_nxt = STATES.AIR
var state_cur = -1


onready var rotate = get_node( "rotate" )
var dir_cur = 1
var dir_nxt = 1


enum CHARS{ SQR, TRI, CIR }
var char_cur = -1
var char_nxt = CHARS.SQR
var char_name_cur = "box"
var cur_type = 0



onready var anim = get_node( "anim" )
var anim_cur = ""
var anim_nxt = "idle"
var anim_name_nxt = "box idle"
var anim_name_cur = ""


onready var rays = [ get_node( "ray_1" ), get_node( "ray_2" ) ]


func _on_ground():
	if rays[0].is_colliding() or rays[1].is_colliding():
		return true
	return false




func _ready():
	game.player = weakref( self )
	game.camera_target = weakref( self )
	for r in rays:
		r.add_exception( self )
	set_fixed_process( true )


func _fixed_process(delta):
	#print( _on_ground() )
	state_cur = state_nxt
	
	if state_cur == STATES.AIR:
		_state_air( delta )
	elif state_cur == STATES.GROUND:
		_state_ground( delta )
	
	# motion
	vel = move_and_slide( vel )
	
	# character
	if char_nxt != char_cur:
		char_cur = char_nxt
		if char_cur == CHARS.SQR:
			char_name_cur = "box"
		elif char_cur == CHARS.TRI:
			char_name_cur = "tri"
		elif char_cur == CHARS.CIR:
			char_name_cur = "cir"
	
	# direction
	if dir_nxt != dir_cur:
		dir_cur = dir_nxt
		rotate.set_scale( Vector2( dir_cur, 1 ) )
	
	# animation
	var anim_name_nxt = char_name_cur + " " + anim_nxt
	if anim_name_nxt != anim_name_cur:
		anim_name_cur = anim_name_nxt
		print( "player animation: ", anim_name_cur )
		anim.play( anim_name_cur )
	


func _state_air( delta ):
	_air_time += delta
	# gravity
	vel.y += GRAV * delta
	if vel.y > 0:
		vel.y = min( vel.y, TERM_VEL )
	# input 
	if btn_left.check() == 2:
		vel.x = lerp( vel.x, -MAX_VEL_AIR, ACCEL_AIR * delta )
		dir_nxt = -1
	elif btn_right.check() == 2:
		vel.x = lerp( vel.x, MAX_VEL_AIR, ACCEL_AIR * delta )
		dir_nxt = 1
	else:
		vel.x = lerp( vel.x, 0, ACCEL_AIR * delta )
	
	if vel.y > 0: anim_nxt = "jump down"
	
	# check if on ground
	if _on_ground() and _air_time > 0.1:
		print( "landing" )
		get_node( "anim_fx" ).play( "land" )
		state_nxt = STATES.GROUND
		_is_jump = false


func _state_ground( delta ):
	
	# gravity
	vel.y += GRAV * delta
	# input 
	if btn_left.check() == 2:
		vel.x = lerp( vel.x, -MAX_VEL, ACCEL * delta )
		anim_nxt = "run"
		dir_nxt = -1
	elif btn_right.check() == 2:
		vel.x = lerp( vel.x, MAX_VEL, ACCEL * delta )
		anim_nxt = "run"
		dir_nxt = 1
	else:
		vel.x = lerp( vel.x, 0, ACCEL * delta )
		anim_nxt = "idle"
		if abs( vel.x ) < 2:
			vel.x = 0
			
	
	if btn_jump.check() == 1:
		if _on_door:
			print( "entering door" )
			_enter_door()
		elif not _is_jump:
			_is_jump = true
			vel.y -= JUMP_SPEED
			state_nxt = STATES.AIR
			anim_nxt = "jump up"
			get_node( "anim_fx" ).play( "jump" )
			_air_time = 0
	

	
	if not _on_ground():
		state_nxt = STATES.AIR
		_air_time = 0

var door_area = null
func _on_door_check_area_enter( area ):
	if area.is_in_group( "door" ):
		if not _on_door:
			door_area = weakref( area )
			_on_door = true



func _on_door_check_area_exit( area ):
	if area.is_in_group( "door" ):
		door_area = null
		if _on_door: _on_door = false


func _enter_door():
	if door_area != null and door_area.get_ref() != null:
		# check door type
		print( "door type: ", door_area.get_ref().get_type(), " current type: ", cur_type )
		if door_area.get_ref().get_type() != cur_type:
			return
		
		door_area.get_ref().enter()
		yield( door_area.get_ref(), "_on_entered" )
		hide()
		door_area.get_ref().close()
		yield( door_area.get_ref(), "_on_closed" )
		get_parent().level_complete()
		queue_free()

func _on_pickup_area_area_enter( area ):
	if area.is_in_group( "item" ):
		area.get_parent()._on_player = true
		
	pass # replace with function body


func _on_transform_area_area_enter( area ):
	char_nxt = area.type
	cur_type = char_nxt
	area.change_type()
	get_node( "Particles2D" ).set_emitting( true )
	

