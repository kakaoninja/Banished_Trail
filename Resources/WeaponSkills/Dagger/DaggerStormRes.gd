extends WeaponSkillStatsRes
class_name DaggerStormRes

var groups = [
	"STATIONARY",
	"CIRCULAR",
	"ROTATING",
	"AREA",
]

var hit 		= 3
var aspeed		= 1.1
var pspeed		= 100
var proj		= 2

func set_base_stats (res):
	res.set_projectiles (proj)
	res.set_baseHitDamage (hit)
	res.set_baseAttackSpeed (aspeed)
	res.set_baseProjectileSpeed (pspeed)
