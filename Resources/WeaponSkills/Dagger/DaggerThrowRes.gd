extends WeaponSkillStatsRes
class_name DaggerThrowRes

var groups = [
	"PROJECTILE",
	"ROTATING",
	"PIERCING",
	"ATTACKSPEED",
	"RETURNING",
]

var hit 		= 3
var aspeed		= 1.2
var pspeed		= 100
var proj		= 3

func set_base_stats (res):
	res.set_projectiles (proj)
	res.set_baseHitDamage (hit)
	res.set_baseAttackSpeed (aspeed)
	res.set_baseProjectileSpeed (pspeed)
