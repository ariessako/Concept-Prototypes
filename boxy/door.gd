tool
extends Area2D

signal _on_entered
signal _on_closed


enum TYPES { SQR, TRI, CIR, SQRTRI, SQRCIR, TRICIR }
export var type = TYPES.SQR setget _set_type

func _ready():
	get_node( "Sprite" ).set_frame( type )

func _set_type( val ):
	type = val
	if get_node( "Sprite" ) != null:
		get_node( "Sprite" ).set_frame( type )

func get_type():
	return type

func enter():
	get_node( "anim" ).play( "enter" )

func close():
	get_node( "anim" ).play_backwards( "enter" )

