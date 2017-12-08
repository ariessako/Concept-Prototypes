extends Node

var player = null
var camera = null
var camera_target = null
var cur_level = "res://level_1.tscn"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func get_player():
	if player != null and player.get_ref() != null:
		return player
	return null