extends Light2D

onready var HealthUI = find_parent ("HealthUI")

func _process(delta):
	rotation (delta * 1.5)

func rotation (degrees):
	self.rotation_degrees += degrees*2000
