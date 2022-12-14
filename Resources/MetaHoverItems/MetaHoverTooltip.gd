extends Control

onready var label = get_node ("hoverLabel")

var tooltipText
var seconds = 0.0
var mousePos = Vector2.ZERO
var origin

func _ready():
	if tooltipText != null:
		label.text = str(tooltipText)
	origin = get_viewport_rect().size / 2

func _process(_delta):
	rect_position = get_global_mouse_position()
	flip_middle()
	

func flip_middle ():
	get_mousePosition ()
	#print (parentPos)
	if mousePos.y >= origin.y:
		label.grow_vertical = 0
	if mousePos.y < origin.y:
		label.grow_vertical = 1
	if mousePos.x >= origin.x:
		label.grow_horizontal = 0
	if mousePos.x < origin.x:
		label.grow_horizontal = 1

func get_mousePosition ():
	mousePos = get_global_mouse_position()
