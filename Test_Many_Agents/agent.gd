extends RigidBody2D

const MAX_VEL = 250

onready var target_pos = position
var half_dist_sq = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed( "btn_mouse" ):
		target_pos = get_global_mouse_position()
		half_dist_sq = ( target_pos - position ).length() / 2
		half_dist_sq *= half_dist_sq

func _integrate_forces( state ):
	var distance_to_target = target_pos - position
	var distance_sq = distance_to_target.length_squared()
	var desired_velocity = distance_to_target.normalized() * MAX_VEL
	if distance_sq < half_dist_sq:
		desired_velocity *= ( distance_sq / half_dist_sq )
	var steering_force = desired_velocity - state.linear_velocity
	var new_velocity = ( state.linear_velocity + steering_force ).clamped( MAX_VEL )
	state.linear_velocity = new_velocity