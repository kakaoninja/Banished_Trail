extends ProfessionRes
class_name CritterRes
"""
"Critting" Upgrade: SL1- C3
Unique Passives
Has 4 hearts
Gain 50% CritMultiplier
increase baseCrit by 5%

ClassSkill:
	ShadowStep:
		become untargetable in the Shadows, for 3 seconds

quest
Hitting an enemy with a crit grants a power charge giving 10% crit and 20% critmulti [5]

boss
objects that shatter on crit in the direction youre facing, area and damage scales with critmulti
"""
var hp		= 4.0
var crit	= 10.0
var multi	= 200.0

func ready():
	set_maxCores		(hp)
	set_baseCritChance	(crit)
	set_baseCritMulti	(multi)
