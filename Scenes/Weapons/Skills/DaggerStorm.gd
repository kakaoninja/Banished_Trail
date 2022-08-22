extends KinematicBody2D
var weaponSkillStatsRes: WeaponSkillStatsRes = load ("res://Resources/WeaponSkills/WeaponSkillStatsRes.tres")
var playerStatsRes: PlayerStatsRes = load ("res://Resources/PlayerStatsRes.tres")

#idea new projectiles at offset

onready var particleNode	= get_node ("Sprite/WeaponTrail")
onready var areaCollision	= get_node ("AreaCollision")
onready var parent			= get_parent()
onready var sprite			= get_node ("Sprite")

var rotationDegrees		= 0.0
var rotationRadians		= 0.0

var rotationOffset		= 30.0		#offset for positioning the whole object
var graphicsOffset		= 0.0		#offset for positioning the sprite

var projectileDuration	= 0.0		#static

var rotationCurve		= 0.0
var movementCurve		= 0.0
var accelerationCurve	= 0.0
var animationStep		= 0.0
var curveFinished: bool	= false

var projectileVector	= Vector2.ZERO
var projectileMove		= Vector2.ZERO

var combinedVector		= Vector2.ZERO
var combinedMove		= Vector2.ZERO

var snapshotAimDegrees

func _ready():
	areaCollision.connect ("body_entered", self, "collision_handling")
	self.set_position (playerStatsRes.playerPosition)

func _process(delta):
	weaponSkillStatsRes.movement (parent, self, delta)
	weaponSkillStatsRes.rotate_everything (parent, self, self, particleNode, rotationOffset, delta)
	if animationStep >= 100:
		curveFinished = true

func collision_handling (_body):
	pass
