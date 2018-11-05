extends Camera2D

var target = null
var ground_shader = null

func _ready():
	target = get_parent().find_node( "robot" )
	if target == null:
		print( name, ": could not find robot" )
		set_physics_process( false )
		

func _physics_process(delta):
	position = target.position