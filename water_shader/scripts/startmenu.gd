extends Node2D

onready var global = get_node( "/root/global" )
var input_states = preload( "res://scripts/input_states.gd" )
var playernm = "player_1"
var btn_p1 = input_states.new( "p1_btn_up" )
var btn_p2 = input_states.new( "p2_btn_up" )


func _ready():
	get_node( "anim" ).play( "anykey" )
	get_node( "p1" ).set_text( global.gamestate["player_1"]["type"] )
	get_node( "p2" ).set_text( global.gamestate["player_2"]["type"] )
	set_fixed_process( true )

func _fixed_process(delta):
	if btn_p1.check() == 1:
		if global.gamestate["player_1"]["type"] == "human":
			global.gamestate["player_1"]["type"] = "ai"
		else:
			global.gamestate["player_1"]["type"] = "human"
		get_node( "p1" ).set_text( global.gamestate["player_1"]["type"] )
	if btn_p2.check() == 1:
		if global.gamestate["player_2"]["type"] == "human":
			global.gamestate["player_2"]["type"] = "ai"
		else:
			global.gamestate["player_2"]["type"] = "human"
		get_node( "p2" ).set_text( global.gamestate["player_2"]["type"] )
	if Input.is_key_pressed( KEY_SPACE ):
		global.main.change_map( "game" )

#func _input( event ):
#	if event.type == InputEvent.KEY:
		
