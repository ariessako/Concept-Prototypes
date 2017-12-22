extends KinematicBody2D

#---------------------------------------
# player input
#---------------------------------------
var input_states = preload( "res://scripts/input_states.gd" )
var btn_left = input_states.new( "btn_left" )
var btn_right = input_states.new( "btn_right" )
var btn_up = input_states.new( "btn_up" )
var btn_fire = input_states.new( "btn_fire" )

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
