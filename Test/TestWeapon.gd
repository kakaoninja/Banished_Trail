extends Node2D

export (Resource) var Stats
export (Curve) var RotationCurve

export var rotationValue = 0.0
# slow attackspeed scaling with high base damage
# NOT AFFECTED BY PROJECTILE SPEED
"""
func _ready():
	WeaponSkillStats.baseDamage				= 8
	WeaponSkillStats.baseAttackSpeed		= 0.6
	WeaponSkillStats.baseProjectileSpeed	= 0
"""

var fullCircle = -360
#onready var swordSprite = $SwordSprite
onready var ParticleMaterial = preload("res://Resources/Pixelparticle.tres")


func _ready():
	self.add_to_group ("STATIONARY")
	self.add_to_group ("CIRCULAR")

func _physics_process(delta):
	var aim = get_global_mouse_position()
	#look_at(aim)
	circleRotation(delta)
	rotate(rotationValue * 5)

	#rotate_particles()

#FIXME put this in Animator Singleton
func circleRotation (delta):
	var InterpolatorRotation = 0.0
	InterpolatorRotation += delta
	if InterpolatorRotation > 1.0:
		InterpolatorRotation -= 1.0
	rotationValue = self.RotationCurve.interpolate_baked (delta)

func rotate_particles ():
	ParticleMaterial.angle = -rotation_degrees
