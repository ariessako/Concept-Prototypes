extends Node

var main = null

var gamestate = { \
	"player_1" : { \
		"type" : "ai", \
		"score" : 0 }, \
	"player_2": { \
		"type" : "human", \
		"score" : 0 } }


func _ready():
	randomize()
	var _root = get_tree().get_root()
	main = _root.get_child( _root.get_child_count() - 1 )
	reset_scores()
	set_process( true )
	#set_fixed_process( true )

var oldscore_p1 = 0
var oldscore_p2 = 0
func _process( delta ):
	if Input.is_key_pressed( KEY_ESCAPE ):
		get_tree().quit()
	if oldscore_p1 != gamestate["player_1"]["score"]:
		oldscore_p1 = gamestate["player_1"]["score"]
		main.get_node( "HUD_Layer/HUD/p1_score" ).set_text( "%d" % oldscore_p1 )
	if oldscore_p2 != gamestate["player_2"]["score"]:
		oldscore_p2 = gamestate["player_2"]["score"]
		main.get_node( "HUD_Layer/HUD/p2_score" ).set_text( "%d" % oldscore_p2 )
	


func reset_scores():
	gamestate["player_1"]["score"] = 0
	gamestate["player_2"]["score"] = 0
