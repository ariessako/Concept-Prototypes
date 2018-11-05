extends Sprite

var camera = null

func _ready():
	# find camera
	camera = get_parent().find_node( "camera" )
	if camera == null:
		set_physics_process( false )
		print( name, ": could not find camera" )
	

func _physics_process( delta ):
	# set material property
	material.set_shader_param( "pos", camera.get_camera_screen_center().x )
