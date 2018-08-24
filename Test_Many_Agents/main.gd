extends Node2D

export(int) var agent_count = 1000
export(float) var agent_spacing = 50
export(Vector2) var offset = Vector2( 200, 200 )

var agent_scn = preload ( "./agent.tscn" )

func _ready():
	call_deferred( "_initialize_agents" )


func _initialize_agents():
	var side_count = ceil( sqrt( agent_count ) )
	var pos = Vector2()
	for count in range( agent_count ):
		var a = agent_scn.instance()
		a.position = pos * agent_spacing + offset
		add_child( a )
		
		pos.x += 1
		if pos.x >= side_count:
			pos.x = 0
			pos.y += 1

