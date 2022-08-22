extends Light2D

onready var HealthUI = find_parent ("HealthUI")

func _process(_delta):
	pulse (HealthUI.energyLevel - 0.18)
	
func pulse (energyLvl):
	self.energy = energyLvl

