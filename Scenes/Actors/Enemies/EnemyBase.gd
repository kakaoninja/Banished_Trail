extends KinematicBody2D

func die():
		queue_free()

func _on_Hurtbox_area_entered(area):
	die()
