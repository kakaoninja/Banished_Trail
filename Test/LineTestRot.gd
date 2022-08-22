extends Node2D

onready var line = get_child (0)
onready var host = get_parent()
onready var pos

var trailLength = 100

func _process(delta):
	pos = position
	rotation_degrees = host.rotation_degrees 
	pos.x = cos(host.rotation_degrees) + host.position.x
	pos.y = sin(host.rotation_degrees) + host.position.y
	line.add_point(pos)
	while line.get_point_count() > trailLength:
		line.remove_point(0)

"""
func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	line.add_point(host.global_position)
	yield (get_tree().create_timer(0.5), "timeout")
	while line.get_point_count() > trailLength:
		line.remove_point(0)
	pass
"""
