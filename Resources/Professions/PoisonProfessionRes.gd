extends ProfessionRes
class_name PoisonRes

"""
"Poison" Upgrade: D0- T1M3
Unique Passives
Has 5 hearts
Your Main Weapon Skill Applies Poison for 2 Seconds which doesnt have a stack size limit.
30% more Damage with Dots
20% less Damage with Hits

quest
Your Poison spreads from dead Enemies, when enemies walk over it
Enemies that bleed explode on death, dealing 10% damage

boss
Orbs around the boss, you can only kill the boss by killing its adds
occasionally casts an explosion

Class Ability:
	passively gather Dot Stacks, release for big AOE
"""

var hp		= 4
var dot		= 0.3
var hit		= 0.2
var dotdur	= 1.0
var crit	= 5.0
var multi	= 200.0

func ready():
	dotBasedOnHit = true
	set_maxCores		(hp)
	set_baseDotDuration	(dotdur)
	set_moreDotDamage	(moreDotDamage + dot)
	set_moreHitDamage	(moreHitDamage - hit)
	set_baseCritChance	(crit)
	set_baseCritMulti	(multi)
