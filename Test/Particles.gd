extends Node2D

onready var particle = preload ("res://Particles/Pixelparticle.tres")
onready var host = get_parent()
onready var Sprite = get_parent().get_node("Sprite")
var particleAmount
"""
func _ready():
	for i in particleAmount.y:
		pass
"""
