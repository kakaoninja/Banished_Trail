extends Resource
class_name AnimationTime

var animationTime = 0.0
var animationSpeed = 1.0

func calc_animationTime (delta, maximum):
	animationTime += delta
	if animationTime >= maximum / animationSpeed:
		animationTime = 0.0
