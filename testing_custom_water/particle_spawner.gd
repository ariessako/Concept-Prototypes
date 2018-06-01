extends Node2D


onready var particle_scn = preload( "res://particle.tscn" )


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Timer_timeout():
	# spawn particle
	var p = particle_scn.instance()
	p.position = position
	p.apply_impulse( Vector2(), Vector2( rand_range( 500, 600 )/100, 0 ) )
	var sc = rand_range( 0.2, 0.9 )
	for c in p.get_children():
		c.scale *= sc
	get_parent().add_child( p )

