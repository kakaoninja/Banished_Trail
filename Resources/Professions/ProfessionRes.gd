extends PlayerStatsRes
class_name ProfessionRes

var professionID

"""
var prof_critter	= load ("res://Resources/Professions/CritterProfession.tres")
var prof_poison		= load ("res://Resources/Professions/PoisonProfession.tres")
var prof_pyro		= load ("res://Resources/Professions/PyroProfession.tres")
var prof_rage		= load ("res://Resources/Professions/RageProfession.tres")
var prof_ranger		= load ("res://Resources/Professions/RangerProfession.tres")
"""

var critter_sprite	= preload ("res://Sprites/Actors/Player/CritterPlayerSprite.png")
var poison_sprite	= preload ("res://Sprites/Actors/Player/PoisonPlayerSprite.png")
var pyro_sprite		= preload ("res://Sprites/Actors/Player/PyroPlayerSprite.png")
var rage_sprite		= preload ("res://Sprites/Actors/Player/RagePlayerSprite.png")
var ranger_sprite	= preload ("res://Sprites/Actors/Player/RangePlayerSprite.png")


var emergency_critter_sprite	= preload ("res://Sprites/Actors/Player/EmergencyCritterPlayerSprite.png")
var emergency_poison_sprite		= preload ("res://Sprites/Actors/Player/EmergencyPoisonPlayerSprite.png")
var emergency_pyro_sprite		= preload ("res://Sprites/Actors/Player/EmergencyPyroPlayerSprite.png")
var emergency_rage_sprite		= preload ("res://Sprites/Actors/Player/EmergencyRagePlayerSprite.png")
var emergency_ranger_sprite		= preload ("res://Sprites/Actors/Player/EmergencyRangePlayerSprite.png")

var critterTooltip: Array = [
	"Critting Upgrade:\n", "[color=#BA1C1C]SL1- C3[/color]\n", "Unique Passives\n", "[url]MaxCores[/url]: 3\n", "[url]base[/url] [url]CritChance[/url]: +5%\n", "[url]base[/url] [url]CritMulti[/url]: +50%\n"
	]
var poisonTooltip: Array = [
	"Poison Upgrade:\n", "[color=#BA1C1C]D0- TS[/color]\n", "Unique Passives:\n", "[url]MaxCores[/url]: 4\n", "[url]more[/url] [url]DotDamage[/url]: +30%\n", "[url]less[/url] [url]HitDamage[/url]: -20%\n", "Your skill applies poison\nfor 1 second.\nNo StackSize Limit.\nPoison scales with\n[url]HitDamage[/url]"
	]
var pyroTooltip: Array = [
	"Pyro Upgrade:\n", "[color=#BA1C1C]BL- 4Z3[/color]\n", "Unique Passives:\n", "[url]MaxCores[/url]: 4\n", "[url]more[/url] [url]DotDamage[/url]: +30%\n", "[url]less[/url] [url]HitDamage[/url]: -20%\n", "Your skill applies\nburning for 3 seconds.\nThis is refreshed on hit.\nBurning scales with\n[url]DotDamage[/url]"
	]
var rageTooltip: Array = [
	"Rage Upgrade:\n", "[color=#BA1C1C]FU- RY[/color]\n", "Unique Passives:\n", "[url]MaxCores[/url]: 6\n", "WIP"
	]
var rangerTooltip: Array = [
	"Ranging Upgrade:\n", "[color=#BA1C1C]R3- 4CH[/color]\n", "Unique Passives:\n", "[url]MaxCores[/url]: 3\n", "[url]more[/url] [url]ProjectileSpeed[/url]: +50%\n", "[url]add[/url] [url]Projectiles[/url]: +2\n"
	]

var profession_dict = {
	"dictCritter":		[critterTooltip,	Color(0.24, 0.29, 0.93),	critter_sprite,	emergency_critter_sprite],
	"dictPoison":		[poisonTooltip,		Color(0.26,0.86,0.13),		poison_sprite,	emergency_poison_sprite],
	"dictPyro":			[pyroTooltip,		Color(0.96, 0.65, 0),		pyro_sprite,	emergency_pyro_sprite],
	"dictRage":			[rageTooltip,		Color(1, 0.36, 0.01),		rage_sprite,	emergency_rage_sprite],
	"dictRanger":		[rangerTooltip,		Color(0.26, 0.86, 0.13),	ranger_sprite,	emergency_ranger_sprite],
	"dictEmergency":	[Color(0.98, 0, 0.41)]
}


"""
func set_profession_identifier (profID):
	professionID = profID
"""


func set_player_sprite_and_color (profID):
	var color
	var sprite
	if emergencyMode == true:
		color = profession_dict["dictEmergency"]
		sprite = profession_dict[profID][3]
		return [color, sprite]
	else:
		color = profession_dict[profID][1]
		sprite = profession_dict[profID][2]
		return [color, sprite]
