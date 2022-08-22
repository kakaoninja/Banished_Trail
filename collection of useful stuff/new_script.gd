extends Node

func mouse_aim_vector(owner):
	var mousePosition	= Vector2 (owner.get_global_mouse_position())
	var combinedVector	= Vector2.ZERO
	combinedVector = mousePosition - PlayerStatsRes.playerPosition
	return combinedVector.normalized()
