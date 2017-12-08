extends Area2D

export var type = 0 setget _set_type

func _ready():
	get_node( "Sprite" ).set_frame( type )

func _set_type( val ):
	type = val
	if get_node( "Sprite" ) != null:
		get_node( "Sprite" ).set_frame( type )

var _removed = false
func change_type():
	if _removed: return
	_removed = true
	queue_free()
	return