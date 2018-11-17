extends Node2D

var particle_scn = preload( "res://particle.tscn" )
#var refpos = null
#var radius = 0
var initial_position = null
var generating_position = Vector2()
var average_height = 10

func _ready():
	# find the position2d that sets the radius and starting point
	var refpos_node = find_node( "ref_pos" )
	if refpos_node == null:
		# did not find the node...
		set_physics_process( false )
		print( name, ": could not find ref_pos node" )
		return
	# save initial position
	initial_position = refpos_node.position
	
	# create tween to move point of particle generation
	var tw = Tween.new()
	tw.interpolate_method( self, "_move_refpos", \
		0, 360, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, 0 )
	tw.repeat = true
	add_child( tw )
	tw.start()
	
	# create tween to move height of particles
	var th = Tween.new()
	th.interpolate_method( self, "_move_height", \
		5, 20, 3, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, 0 )
	th.interpolate_method( self, "_move_height", \
		20, 5, 3, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, 3 )
	th.repeat = true
	add_child( th )
	th.start()
	
	# start timer to generate particles
	$generating_timer.start()

func _move_refpos( angle_offset ):
	generating_position = initial_position.rotated( deg2rad( angle_offset ) )

func _move_height( h ):
	average_height = h


# a function to generate particles depending on the current generating position
func _on_generating_timer_timeout():
	var random_offset = Vector2( rand_range( -1, 1 ), rand_range( -1, 1 ) )
	var random_height_offset = rand_range( -1, 1 )
	var p = particle_scn.instance()
	p.position = position + generating_position + random_offset
	p.height = average_height + random_height_offset
	get_parent().add_child( p )
