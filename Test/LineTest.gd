extends Node2D

onready var line = get_child (0)
onready var host = get_parent ()
var lineWidth = 2

var trailLength = 20

var cooldown	= 0.0
export var timerCount	= 0.0

func _process(delta):
	cooldown += delta
	line.global_position = Vector2.ZERO
	line.global_rotation = 0
	if cooldown > 1.0/200:
		line.add_point(host.global_position)
		while line.get_point_count() > trailLength:
			line.remove_point(0)
		cooldown = 0.0


func _ready():
	line.default_color = Color(1,1,1, 0.4)
	line.texture_mode = 2
	line.width = lineWidth
	#dline.texture = load ("res://Sprites/Animations/trail_texture.png")
