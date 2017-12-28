extends KinematicBody2D

const MAX_VEL = 100
const GRAVITY = 100
var vel = Vector2()

var blood_scn = preload( "res://blood_particles.tscn" )

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	#$Label.text = str( 1 / delta  - Engine.get_frames_per_second())
	if Input.is_action_pressed( "btn_left" ):
		vel.x = -MAX_VEL
	elif Input.is_action_pressed( "btn_right" ):
		vel.x = MAX_VEL
	else:
		vel.x = 0
	vel.y += GRAVITY * delta
	
	vel = move_and_slide( vel )
	
	
	if Input.is_action_just_pressed( "btn_test" ):
		# start blood
		var blood = blood_scn.instance()
		blood.position = position + Vector2( 0, -10 )
		get_parent().add_child( blood )
