extends Node2D

onready var animPlayer		= get_node("AnimationPlayer")
onready var weaponSprite	= get_node("Sprite")

var attackstate = false
#var attackspeed = setget PlayerStats.set_attack_speed

func _process(_delta):
#aiming
	var aim = get_global_mouse_position()
	look_at(aim)

func _unhandled_input(event: InputEvent) -> void:
	pass
	
	if Input.is_action_pressed("attack"):
		animPlayer.play("attack")
	elif Input.is_action_just_released("attack"):
		animPlayer.play("RESET")
