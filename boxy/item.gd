tool
extends Area2D


var _on_player = false
var type = 0 setget _set_type

func _ready():
	get_node( "Sprite" ).set_frame( type )



func _set_type( val ):
	type = val
	if get_node( "Sprite" ) != null:
		get_node( "Sprite" ).set_frame( type )