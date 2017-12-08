extends KinematicBody2D

#--------------------------------------
# behavior
#--------------------------------------
enum BEHAVIORS { HORIZONTAL }
var behavior = BEHAVIORS.HORIZONTAL

#--------------------------------------
# motion
#--------------------------------------
var vel = Vector2( 100, 0)


func _ready():
	pass

func _physics_process(delta):
	if behavior == BEHAVIORS.HORIZONTAL:
		_behavior_horizontal( delta )


func _behavior_horizontal( delta ):
	# move left or right until running into obstacle then reversing motion
	var cinfo = move_and_collide( vel * delta )
	if cinfo != null:
		vel.x = -vel.x
	pass
