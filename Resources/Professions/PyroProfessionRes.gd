extends ProfessionRes
class_name PyroRes
"""
"Pyro" Upgrade: F1- R3
Unique Passives
Has 3 hearts
Your Main Weapon Skill Applies Burning
30% more Damage with Burning
20% less Damage with Hits


Quest
Burning spread to Enemies in [100] radius

boss
charges you, leaving a burning void if burning, for 5 seconds

"""
var hp		= 3
var dot		= 0.3
var hit		= 0.2
var dur		= 3
var speed	= 120

func ready():
	dotBasedOnHit = false
	set_maxCores			(hp)
	set_baseMovementSpeed	(speed)
	set_baseDotDuration		(baseDotDuration + dur)
	set_moreDotDamage		(moreDotDamage + dot)
	set_moreHitDamage		(moreHitDamage - hit)
