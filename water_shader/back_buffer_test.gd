extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# center screen
	var screen_size = OS.get_screen_size( 0 )
	var window_size = OS.get_window_size()
	OS.set_window_position( screen_size * 0.5 - window_size * 0.5 )
	
	# start animation
	get_node( "AnimationPlayer" ).play( "sunset", -1, 0.5 )
