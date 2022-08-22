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
var aspeed		= 0.9
var pspeed		= 80
var proj		= 1

func set_base_stats (res):
	res.set_projectiles (proj)
	res.set_baseHitDamage (hit)
	res.set_baseAttackSpeed (aspeed)
	res.set_baseProjectileSpeed (pspeed)
