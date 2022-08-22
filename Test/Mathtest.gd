extends Node2D

var x

var counter	= 0
var end		= 10

func _process(delta):
	if counter < end:
		x = counter * counter
		counter += 0.1
		print (x)

func _on_Timer_timeout():
	pass
