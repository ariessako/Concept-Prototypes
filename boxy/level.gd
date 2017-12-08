extends Node2D

var startpos = Vector2()

func _ready():
	if game.get_player() != null:
		startpos = game.get_player().get_ref().get_global_pos()
	pass



func level_complete():
	print( "Level Complete" )





func _on_dead_body_enter( body ):
	if game.get_player() != null:
		if body == game.get_player().get_ref():
			game.get_player().get_ref().set_global_pos( startpos )
