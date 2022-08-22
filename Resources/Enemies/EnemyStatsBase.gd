extends Resource
class_name EnemyStatsBase

onready var playerStats = load ("res://Resources/PlayerStats.tres")

var movementSpeed	= 100 setget set_movementSpeed
var damage			= 1.0 setget set_damage
var size			= 1.0 setget set_size

func set_size (value):
	size *= value

func set_damage (value):
	damage *= value

func set_movementSpeed (value):
	movementSpeed *= value

func move_towards_player ():
	pass

func shoot_towards_player ():
	var currentPlayerPos = playerStats.playerPosition
