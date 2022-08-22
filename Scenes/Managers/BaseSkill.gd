extends Node2D
export (Resource) var weaponSkillStats = load ("res://Resources/WeaponSkillStats/WeaponSkillStats.tres")

onready var player				= get_node ("%Player")
onready var pathWeaponSkill		= load ("res://Test/RotatingWeapon.tscn")#FIXME path to actual weapon
#onready var pathWeaponSkill		= load ("res://Test/TestWeapon.tscn")
onready var attackSpeedCD		= get_node ("AttackSpeedTimer")
onready var ActualWeaponSkill	= get_node ("%ActualWeaponSkill")
onready var SkillSpawner		= get_node ("SkillSpawner")
var baseWeaponSkill

#projectiles bounce off walls

#new projectiles show their base weapon to get where youre aiming
#eg. 3 daggers point towards mouse pos
func _ready():
	add_child (pathWeaponSkill.instance())
	baseWeaponSkill = get_child (1)
	print (baseWeaponSkill)
	set_modulate (Color(1,1,1,0))
	pass

