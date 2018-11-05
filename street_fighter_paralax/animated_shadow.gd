extends Sprite

var robot = null
var sprite = null
var initial_y = null
var initial_robot_y = null

var initial_delta = null

func _ready():
	initial_y = position.y
	robot = get_parent().find_node( "robot" )
	if robot != null:
		sprite = robot.find_node( "Sprite" )
		initial_robot_y = robot.position.y
		initial_delta = position.y - robot.position.y
	if sprite == null:
		set_physics_process( false )

func _physics_process(delta):
	position.x = robot.position.x
	position.y = initial_y - ( initial_delta - ( initial_y - robot.position.y ) ) * 0.25
	frame = sprite.frame
	
	material.set_shader_param( "shadow_dir", Vector2( position.x / 230.0 * 1.2, 0.25 ) );
