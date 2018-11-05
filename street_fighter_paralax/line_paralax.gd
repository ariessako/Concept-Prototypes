extends ParallaxBackground

export( Texture ) var bg = null

var prange = [ 1 - 0.17, 1 + 0.2 ]

func _ready():
	
	
	# texture size
	var h = bg.get_height()
	var w = bg.get_width()
	# create as many paralax layers
	for idx in range( h ):
		# the layer
		var l = ParallaxLayer.new()
		l.motion_scale = Vector2( lerp( prange[1], prange[0], float( idx ) / float( h ) ), 1 )
		
		# the sprite
		var s = Sprite.new()
		s.texture = bg
		s.centered = false
		s.region_enabled = true
		s.region_rect = Rect2( \
								Vector2( 0, h - idx ), \
								Vector2( w, 1 ) )
		s.position = Vector2( -w / 2, 180 - idx )
		l.add_child( s )
		add_child( l )
	pass


