extends ProfessionRes
class_name RangerRes
"""
"Ranging" Upgrade R4- NO3

Tags:
	Speed
Unique Passives
Has 3 hearts
All Projectiles Chain an additional Time, this happens after piercing and forking
BulletSpeed +50%
Gain two additional Projectiles

quest
Hitting an attack gives a Stack of Whirlwind, increasing ActionSpeed by 5% for 1 sec [30%]
boss
Many small bullethell
"""

var hp			= 3
var projspeed	= 50
var proj		= 2
var chain		= 1

func ready():
	set_maxCores (hp)
