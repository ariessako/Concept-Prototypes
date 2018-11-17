extends Node2D

var height = 10
var vert_vel = 0
const GRAVITY = 70#100

var start_color = Vector3( 247, 255, 133 ) / 255.0
var end_color = Vector3( 255, 255, 255 ) / 255.0
var initial_energy

func _ready():
	# set initial height
	initial_energy = $sprite/light.energy
	set_height( height )
	
	# set random animation speed
	$anim.playback_speed = rand_range( 0.7, 1 )
	
	# set random color and alpha
	var random_color = start_color.linear_interpolate( end_color, randf() )
	$sprite.modulate = Color( random_color.x, random_color.y, random_color.z, rand_range( 0.7, 1 ) )


func _physics_process( delta ):
	vert_vel -= GRAVITY * delta
	height += vert_vel * delta
	if height <= 0:
		vert_vel = -vert_vel / 2
		height = -height
	
	set_height( height )
	
	
	$sprite.modulate.a = lerp( $sprite.modulate.a, 0, 2 * delta )
	$sprite/light.energy = lerp( $sprite/light.energy, 0, 1 * delta )


func set_height(h):
	$sprite.position.y = -h
	$sprite/light.range_height = -h
	$sprite/light.texture_scale = ( 1 + h / 20 )
	$sprite/light.energy = max( ( initial_energy ), 0 ) / ( 1.0 + $sprite.frame / 2.0 )