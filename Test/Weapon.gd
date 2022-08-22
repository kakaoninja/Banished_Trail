extends Node2D

func _process(_delta):
#aiming
	var aim = get_global_mouse_position()
	look_at(aim)
