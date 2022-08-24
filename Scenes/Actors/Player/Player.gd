extends KinematicBody2D
class_name Player

var playerStatsRes: PlayerStatsRes = load ("res://Resources/PlayerStatsRes.tres")
var professionRes: ProfessionRes = load ("res://Resources/Professions/ProfessionRes.tres")
var weaponSkillStatsRes: WeaponSkillStatsRes = load ("res://Resources/WeaponSkills/WeaponSkillStatsRes.tres")

#initialize nodes
onready var wallDetectArea		= get_node	("WallDetection")
onready var playerSprite 		= get_node	("PlayerSprite")
onready var animationPlayer 	= get_node	("AnimationPlayer")
onready var knockback			= get_node	("KnockbackArea/Knockback")
#onready var reactorLightFlare	= get_node	("ReactorLightFlare")
#onready var reactorLightRound	= get_node	("ReactorLightRound")

#effects

onready var Lightning		= preload	("res://Particles/Lightning.tscn")

var movement		= Vector2.ZERO
var input_vector	= Vector2.ZERO
var facingRight		= true
var playerPosCheck


func _ready ():
	wallDetectArea.connect ("body_entered", self, "wallDetection_body_entered")
	wallDetectArea.connect ("body_exited", self, "wallDetection_body_exited")
	knockback.visible = false
	self.add_to_group ("PLAYER")
	animationPlayer.play("IdleRight")
	playerStatsRes.connect ("no_cores", self, "die")
	

func _process (_delta):
	player_movement ()
	player_position ()


		#playerStatsRes.playerWallHit = true

func color_init (professionSelection):
	professionRes.set_player_sprite_and_color (playerStatsRes.professionID)
	#set color for right profession
	#for ReactorLight
	#for Spritesheet
	pass

func player_position ():
	playerStatsRes.set_player_position (global_position)
	playerStatsRes.set_mouseAngleVector (get_global_mouse_position() - playerStatsRes.playerPosition)
	playerStatsRes.set_mouseAngleRadians (atan2((get_global_mouse_position() - playerStatsRes.playerPosition).y, (get_global_mouse_position() - playerStatsRes.playerPosition).x))
	playerStatsRes.set_player_movement_vector (input_vector)
	

func player_movement ():
#get inputs
	input_vector.x = Input.get_action_strength ("move_right") - Input.get_action_strength ("move_left")
	input_vector.y = Input.get_action_strength ("move_down") - Input.get_action_strength ("move_up")
	input_vector = input_vector.normalized ()
# use inputvector for movement
#	if input_vector != Vector2.ZERO:
#		movement = movement.move_toward (input_vector * playerStatsRes.finalMovementSpeed, playerStatsRes.ACCELERATION)
#	else:
#		movement = movement.move_toward (Vector2.ZERO, playerStatsRes.ACCELERATION)
	if input_vector != Vector2.ZERO:
		movement = input_vector * playerStatsRes.finalMovementSpeed
	else:
		movement = Vector2.ZERO
# warning-ignore:return_value_discarded
	move_and_slide(movement)
	playerStatsRes.set_player_movement_vector (movement)
# Animator
	facing (input_vector.x)
	animator (input_vector)

func animator (moveset):
	if facingRight == true and (moveset.x > 0 or moveset.y != 0):
		animationPlayer.play ("RunRight")
	if facingRight == false and (moveset.x < 0 or moveset.y != 0):
		animationPlayer.play ("RunLeft")
	if (Input.is_action_just_released ("move_right") and moveset.y == 0) or (facingRight == true and moveset == Vector2.ZERO):
		animationPlayer.play ("IdleRight")
	if (Input.is_action_just_released ("move_left") and moveset.y == 0) or (facingRight == false and moveset == Vector2.ZERO):
		animationPlayer.play ("IdleLeft")

func facing (horizontalMovement):
	if horizontalMovement > 0:
		facingRight = true
	elif horizontalMovement < 0:
		facingRight = false

func die (): #FIXME death animation and end screen
	# particles like cables etc and black circle that gets smaller
	queue_free()
	pass


func wallDetection_body_entered(body):
	playerStatsRes.playerWallHit = true

func wallDetection_body_exited(body):
	playerStatsRes.playerWallHit = false


func _on_WallDetection_body_entered(body):
	print (body)
