extends Camera2D


func _ready():
	game.camera = weakref( self )
	
	var top_left = get_node( "top_left" )
	var right_bottom = get_node( "bottom_right" )
	
	if top_left != null and right_bottom != null:
		self.set_limit( 0, top_left.get_global_pos().x )
		self.set_limit( 2, right_bottom.get_global_pos().x )
		self.set_limit( 1, top_left.get_global_pos().y )
		self.set_limit( 3, right_bottom.get_global_pos().y )
	
	set_fixed_process( true )

func _fixed_process(delta):
	if game.camera_target == null: return
	var target = game.camera_target.get_ref()
	if target == null: return
	var newpos = target.get_global_pos()
	newpos.x = round( newpos.x )
	newpos.y = round( newpos.y )
	set_global_pos( newpos )
		
