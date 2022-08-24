extends KinematicBody2D
var weaponSkillStatsRes: WeaponSkillStatsRes = load ("res://Resources/WeaponSkills/WeaponSkillStatsRes.tres")
var playerStatsRes: PlayerStatsRes = load ("res://Resources/PlayerStatsRes.tres")

onready var particleNode	= get_node ("Sprite/WeaponTrail")
onready var areaCollision	= get_node ("AreaCollision")
onready var parent			= get_parent()
onready var sprite			= get_node ("Sprite")

var collisionObject
var bounceVector

var offsetAngle			= 0.0
var rotationDegrees		= 0.0
var rotationRadians		= 0.0

var rotationOffset		= 0.0		#offset for positioning the whole object
var graphicsOffset		= 4.0		#offset for positioning the sprite

var projectileDuration	= 100.0		#static

var rotationCurve		= 0.0
var movementCurve		= 0.0
var accelerationCurve	= 0.0
var animationStep		= 0.0
var curveFinished: bool

var projectileVector	= Vector2.ZERO
var projectileMove		= Vector2.ZERO

var combinedVector		= Vector2.ZERO
var combinedMove		= Vector2.ZERO

var aimDegrees
var playerVector
var playerPosition

func _ready():
	areaCollision.connect ("body_entered", self, "collision_handling")
	self.set_position (playerStatsRes.playerPosition)

func _process(delta):
	weaponSkillStatsRes.movement (parent, self, delta)
	weaponSkillStatsRes.rotate_everything (parent, self, sprite, particleNode, rotationOffset, delta)
	if animationStep >= 1.0:
		curveFinished = true
		animationStep = int (animationStep)
		weaponSkillStatsRes.handle_aimDegrees (self, rad2deg(playerStatsRes.mouseAngleRadians))
		weaponSkillStatsRes.handle_playerVector (self, playerStatsRes.playerMovementVector)

func collision_handling (body):
	pass


func _on_AreaCollision_body_entered(body):
	#print (body)
	pass
