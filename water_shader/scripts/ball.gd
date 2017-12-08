extends KinematicBody2D
onready var global = get_node( "/root/global" )

var velocity = Vector2( -200, 200 )
const GRAVITY = 50

func _ready():
	var dir = randi() % 2
	var vx = randi() % 100 + 100
	var vy = randi() % 100 + 100
	if dir == 0: velocity = Vector2( vx, vy )
	else: velocity = Vector2( -vx, vy )
	set_fixed_process( true )

func _fixed_process( delta ):
	velocity.y += GRAVITY * delta
	var motion = delta * velocity
	move( motion )
	
	if is_colliding():
		global.main.sampleplayer.play( "board" )
		var n = get_collision_normal()
		velocity -= 2 * velocity.dot( n ) * n
		motion = delta * velocity
		move( motion )
			

func _on_check_finish_area_area_enter( area ):
	# score
	if area.get_name() == "finish_area_player_1":
		global.gamestate["player_2"]["score"] += 1
		get_parent().spawn_ball()
		global.main.sampleplayer.play( "score" )
	elif area.get_name() == "finish_area_player_2":
		global.gamestate["player_1"]["score"] += 1
		get_parent().spawn_ball()
		global.main.sampleplayer.play( "score" )
	else:
		var c = area.get_parent()
		if c extends preload( "res://scripts/player.gd" ):
			var dy = ( get_pos().y - c.get_pos().y ) / 16
			var ba = dy * 70 / ( 2 * PI ) # bounce angle
			var nv = abs( dy ) * 300 * 2
			if nv < 200: nv = 200
			velocity = nv * Vector2( -sign( velocity.x ), dy ).normalized()
			global.main.sampleplayer.play( "pop" )
