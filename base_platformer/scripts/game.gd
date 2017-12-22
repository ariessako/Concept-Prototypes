extends Node


var player = null


func get_player():
	if player != null and player.get_ref() != null:
		return player.get_ref()
	return null