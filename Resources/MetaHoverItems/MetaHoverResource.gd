extends Resource
class_name MetaHoverResource

var MetaHoverDict = {
	"base":				"The amount a stat initially starts with.",
	"add":				"Additional increase of a stat before all multipliers.",
	"multiply":			"Increases the flat amount of a stat by the multiply percentage.",
	"more":				"Last increase of a stat at the end of the whole calculation.",
	"less":				"Decreases the total stat, opposite of more.",
	"MaxCores":			"Maximum amount of HP you can have.",
	"CurrentCores":		"Amount of damage you can take before dying. If CurrentCores is smaller than 1, you die.",
	"CurrentShield":	"Amount of how much Shield you have. On taking damage this is reduced first.",
	"MovementSpeed":	"Amount of distance an object can move per second.",
	"AttackSpeed":		"How often an Attack can occur per second.",
	"HitDamage":		"Total amount of damage caused by each hit.",
	"DotDamage":		"Total amount of damage over time caused for a duration after a hit.",
	"DotTickRate":		"Time between each tick of the damage over time.",
	"DotDuration":		"Time the damage over time is applied for.",
	"CritChance":		"Percentage that more damage is done with a hit.",
	"CritMulti":		"Multiplies the damage by that percentage if a critical hit happened.",
	"Projectiles":		"Amount of projectiles a skill can use or shoot.",
	"ProjectileSpeed":	"Speed at which projectiles move per second.",
	"ProjectileSpread":	"Angle at which projectiles fly towards their target.",
	"ProjectileChain":	"Projectiles fly towards additional enemies after hitting an enemy. This happens after fork.",
	"ProjectileFork":	"Projectiles split at a 90 degrees angle after hitting an enemy. This happens after pierce.",
	"ProjectilePierce":	"Projectiles fly straight through enemies. This happens as the first projectile effect.",
	"AreaOfEffect":		"Size multiplier for all skills and secondary effects.",
}
#onready var metaHoverLabel = preload ("res://Resources/MetaHoverItems/MetaHoverTooltip.tscn")
func create_tooltip (parent, metaItem, metaHoverLabel):
	var toolTipText = MetaHoverDict[metaItem]
	var metaToolTip = metaHoverLabel.instance ()
	metaToolTip.tooltipText = toolTipText
	parent.add_child (metaToolTip)
