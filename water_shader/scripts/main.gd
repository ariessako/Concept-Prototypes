extends Node2D

onready var global = get_node( "/root/global" )
onready var loadtimer = get_node( "loadtimer" )
onready var mapobj = get_node( "GameLayer/map" )
onready var sampleplayer = get_node( "sampleplayer" )

var stages = { \
	"startmenu" : "res://scenes/startmenu.tscn", \
	"game" : "res://scenes/game.tscn", \
	"score" : "res://scenes/score.tscn" }

var state = 0
var cur_map = ""

func _ready():
	sampleplayer.play( "pop" )
	change_map( "startmenu" )
	pass

func change_map( map ):
	print( "Changing map: ", map, " - State ", state )
	if state == 0:
		#---------------------------
		# State 0: Hide user interfaces
		#---------------------------
		
		# Set new map
		cur_map = map
		
		# fade out
		get_node( "faders/anim" ).play( "fadeout" )
		
		# Hide everything
		get_node( "HUD_Layer/HUD" ).hide()
		
		# Set new state
		state = 1
		
		# Set timer
		loadtimer.set_wait_time( 0.25 )
		loadtimer.start()
		
	elif state == 1:
		#---------------------------
		# State 1: Delete old map and instance new one
		#---------------------------
		
		# Delete whatever map we have now
		var aux = mapobj.get_children()
		for x in aux: x.queue_free()
		
		# Create new map
		var m = load( stages[cur_map] )
		
		# Instance the new map
		mapobj.add_child( m.instance() )
		
		# show HUD if this is a level map
		if cur_map != "startmenu":
			get_node( "HUD_Layer/HUD" ).show()
		
		# fade in
		get_node( "faders/anim" ).play( "fadein" )
		
		# Set new state
		state = 2
		
		# Set timer
		loadtimer.set_wait_time( 0.25 )
		loadtimer.start()
	else:
		#---------------------------
		# State 2: Show everything
		#---------------------------
		
		
		# Set new state
		state = 0




func _on_loadtimer_timeout():
	change_map( cur_map )
