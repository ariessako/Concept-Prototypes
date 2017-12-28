extends Node2D

var splatter = preload( "res://pixel.png" )


const GRAVITY = 20
var blood = []
class Blood:
	var pos = Vector2()
	var vel = Vector2()
	var bounces = 1
	var lifetime = 1
	var active = true
	

func _ready():
	var nparticles = 100
	for n in range( nparticles ):
		var b = Blood.new()
		b.pos = Vector2( rand_range( -5, 5 ), rand_range( -5, 5 ) )
		b.vel = Vector2( rand_range( -30, -35 ), rand_range( -15, 0 ) )
		b.lifetime = 3 + rand_range( 0, 2 )
		blood.append( b )

func _process(delta):
	# update particles
	var one_active = false
	for b in blood:
		if not b.active: continue
		one_active = true
		b.lifetime -= delta
		if b.lifetime <= 0:
			b.active = false
			continue
		b.vel.y += GRAVITY * delta
		b.pos += b.vel * delta
		# check for collisions
		if _check_collision( b.pos + global_position ):
			if b.bounces > 0:
				b.bounces -= 1
				b.vel.y = -b.vel.y * 0.8
			else:
				var s = Sprite.new()
				s.texture = splatter
				s.position = global_position + b.pos
				s.modulate = Color( 1, 0, 0 )
				get_parent().add_child( s )
				b.active = false
	if one_active:
		update()
	else:
		print( "blood finished" )
		queue_free()

onready var space = get_world_2d().get_direct_space_state()
func _check_collision( pos ):
	
	var result = space.intersect_point( pos, 32, [], 2 )
	if not result.empty():
		return true
	return false


func _draw():
	for b in blood:
		if not b.active: continue
		draw_texture( splatter, b.pos, Color( 1, 0, 0 ) )
