extends Node2D

var ball = null
onready var spawntimer = get_node( "spawntimer" )

func _ready():
	spawn_ball()

func spawn_ball():
	if ball:
		ball.queue_free()
		ball = null
	spawntimer.set_wait_time( 3 )
	spawntimer.start()
	
	

func _on_spawntimer_timeout():
	var pos_y = randi() % 400 + 100
	var m = preload( "res://scenes/ball.tscn" )
	ball = m.instance()
	add_child( ball )
	ball.set_pos( Vector2( 512, pos_y ) )
