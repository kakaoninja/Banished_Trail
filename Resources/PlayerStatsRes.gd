extends Resource
class_name PlayerStatsRes

#--------------------
#init these!
func precalc_stats ():
	final_DotDuration()
	final_HitDamage()
	final_DotDamage()
	final_AreaOfEffect()
	final_AttackSpeed()
	final_CritChance()
	final_CritMulti()
	final_ProjectileSpeed()
	final_ProjectileSpread()
	final_MovementSpeed ()
#--------------------

#--------------------
#startup variables
var chosenProfession	setget ,get_profession
var chosenWeapon		setget ,get_weapon
var chosenSkill			setget ,get_skill

signal got_profession
signal got_weapon
signal got_skill

func get_profession ():
	emit_signal ("got_profession")
	pass

func get_weapon ():
	emit_signal ("got_weapon")
	pass

func get_skill ():
	emit_signal ("got_skill")
	pass
#--------------------

#--------------------
#player movement
var ACCELERATION	= 0.3

var playerWallHit: bool

func playerMovementSpeedCalculation ():
	if playerWallHit != true:
		return finalMovementSpeed
	else:
		return 0.0

var playerPosition = Vector2.ZERO setget set_player_position, get_player_position

func set_player_position (value):
	playerPosition = value

func get_player_position ():
	return playerPosition

var playerMovementVector = Vector2.ZERO setget set_player_movement_vector

func set_player_movement_vector (value):
	playerMovementVector = value

func get_player_movement_vector ():
	return playerMovementVector

var mouseAngleVector = Vector2.ZERO setget set_mouseAngleVector , get_mouseAngleVector

func set_mouseAngleVector (value):
	mouseAngleVector = value

func get_mouseAngleVector ():
	return mouseAngleVector

var mouseAngleRadians = Vector2.ZERO setget set_mouseAngleRadians , get_mouseAngleRadians

func set_mouseAngleRadians (value):
	mouseAngleRadians = value

func get_mouseAngleRadians ():
	return mouseAngleRadians
#--------------------

#--------------------
#emergencyMode

var emergencyMode: bool setget ,get_emergency

signal emergency_mode

func get_emergency ():
	emit_signal("emergency_mode", emergencyMode)
#--------------------

#--------------------
#experience
var level			= 0.0	setget set_level
var experience		= 0.0	setget set_experience
var xpToNextLevel	= 0.0	setget ,get_xp_to_next_level
var displayLevel	setget ,get_display_level

signal level_up
signal xp_to_next_level
signal xp_gained

func get_display_level ():
	return displayLevel

func get_xp_to_next_level ():
	return xpToNextLevel

func calc_next_xp_level (currentLevel):
	xpToNextLevel = 15 + pow(currentLevel, 1.5)
	return xpToNextLevel

func set_experience (xpValue):
	experience += xpValue
	emit_signal ("xp_gained", experience)
	while experience > xpToNextLevel:
		experience -= xpToNextLevel
		set_level (1)

func set_level (value):
	level += value
	displayLevel = level + 1
	emit_signal("level_up", level)
	calc_next_xp_level (level)
	emit_signal("xp_to_next_level", xpToNextLevel)
#--------------------

#--------------------
#health
var maxCores		= 0 setget set_maxCores
var currentCores	= 0 setget set_currentCores
var currentShields	= 0 setget set_currentShields

signal no_cores
signal no_shields
signal current_cores_changed
signal current_shields_changed
signal max_cores_changed

func set_maxCores (value):
	if currentCores == maxCores:
		maxCores = value
		currentCores = maxCores
	elif currentCores <= maxCores:
		if value >= maxCores:
			set_currentCores (currentCores + (value - maxCores))
			maxCores = value
		elif value <= maxCores:
			maxCores = value
	emit_signal ("current_cores_changed", currentCores)
	emit_signal("max_cores_changed", maxCores)

func set_currentCores (value):
	if value > maxCores:
		currentCores = maxCores
	elif value <= maxCores:
		currentCores = value
		emit_signal ("current_cores_changed", currentCores)
	if currentCores == 1:
		emergencyMode = true
	else: 
		emergencyMode = false
	if currentCores < 1:
		currentCores = 0
		emit_signal ("no_cores")

func set_currentShields (value):
	if value > maxCores:
		currentShields = maxCores
	elif value <= maxCores:
		currentShields = value
		emit_signal ("current_shields_changed", currentShields)
	if currentShields <= 0:
		currentShields = 0
		emit_signal ("no_shields")

func take_damage (value):
	if currentShields > 0:
		if value > currentShields:
			value = value - currentShields
			value = currentCores - value
			set_currentShields(0)
			set_currentCores(value)
		else:
			value = currentShields - value
			set_currentShields(value)
	else:
		value = currentCores - value
		set_currentCores(value)

func get_health (value):
	if currentCores == maxCores:
		set_currentShields(currentShields + value)
	elif currentCores < maxCores:
		set_currentCores(currentCores + value)
#--------------------

#--------------------
#temporary buffs
var temporaryModifiers = {}

func add_modifier (id, modifier):
	temporaryModifiers[id] = modifier

func remove_modifer (id):
	temporaryModifiers.erase(id)
#--------------------

#--------------------
#combat states
var luckyCrit: 		bool	= false
var dotBasedOnHit:	bool
#--------------------

#--------------------
#projectiles
var projectiles				= 0	setget set_projectiles			#, get_projectiles
var projectileChains		= 0	setget set_projectileChains		#, get_projectileChains
var projectileForks			= 0	setget set_projectileForks		#, get_projectileForks
var projectilePierces		= 0	setget set_projectilePierces	#, get_projectilePierces

signal got_projectiles
signal got_projectileChains
signal got_projectileForks
signal got_projectilePierces

func set_projectiles (value):
	projectiles = value

func set_projectileChains (value):
	projectileChains = value

func set_projectileForks (value):
	projectileForks = value

func set_projectilePierces (value):
	projectilePierces = value

func get_projectiles ():
	emit_signal("got_projectiles")

func get_projectileChains ():
	emit_signal("got_projectileChains")

func get_projectileForks ():
	emit_signal("got_projectileForks")

func get_projectilePierces ():
	emit_signal("got_projectilePierces")

#movespeed
var baseMovementSpeed		= 100.0	setget set_baseMovementSpeed
var addMovementSpeed		= 0.0	setget set_addMovementSpeed
var multiplyMovementSpeed	= 1.0	setget set_multiplyMovementSpeed
var moreMovementSpeed		= 1.0	setget set_moreMovementSpeed
var finalMovementSpeed		= 0.0

func set_baseMovementSpeed (value):
	baseMovementSpeed = value
	final_MovementSpeed ()
	
func set_addMovementSpeed (value):
	addMovementSpeed = value
	final_MovementSpeed ()

func set_multiplyMovementSpeed (value):
	multiplyMovementSpeed = value
	final_MovementSpeed ()

func set_moreMovementSpeed (value):
	moreMovementSpeed = value
	final_MovementSpeed ()

func final_MovementSpeed ():
	finalMovementSpeed = ((baseMovementSpeed + addMovementSpeed) * multiplyMovementSpeed) * moreMovementSpeed

#Damage
var baseHitDamage			= 3.0	setget set_baseHitDamage
var addHitDamage			= 0.0	setget set_addHitDamage
var multiplyHitDamage		= 1.0	setget set_multiplyHitDamage
var moreHitDamage			= 1.0	setget set_moreHitDamage
var finalHitDamage			= 0.0

func set_baseHitDamage (value):
	baseHitDamage = value
	final_HitDamage ()
	
func set_addHitDamage (value):
	addHitDamage = value
	final_HitDamage ()

func set_multiplyHitDamage (value):
	multiplyHitDamage = value
	final_HitDamage ()

func set_moreHitDamage (value):
	moreHitDamage = value
	final_HitDamage ()

func final_HitDamage ():
	finalHitDamage = ((baseHitDamage + addHitDamage) * multiplyHitDamage) * moreHitDamage

var baseDotTickRate			= 1.0	setget set_baseDotTickRate
var addDotTickRate			= 0.0	setget set_addDotTickRate
var multiplyDotTickRate		= 1.0	setget set_multiplyDotTickRate
var moreDotTickRate			= 1.0	setget set_moreDotTickRate
var finalDotTickRate		= 0.0

func set_baseDotTickRate (value):
	baseDotTickRate = value
	final_DotTickRate ()
	
func set_addDotTickRate (value):
	addDotTickRate = value
	final_DotTickRate ()

func set_multiplyDotTickRate (value):
	multiplyDotTickRate = value
	final_DotTickRate ()

func set_moreDotTickRate (value):
	moreDotTickRate = value
	final_DotTickRate ()

func final_DotTickRate ():
	finalDotTickRate = ((baseDotTickRate + addDotTickRate) * multiplyDotTickRate) * moreDotTickRate

var baseDotDamage			= 3.0	setget set_baseDotDamage
var addDotDamage			= 0.0	setget set_addDotDamage
var multiplyDotDamage		= 1.0	setget set_multiplyDotDamage
var moreDotDamage			= 1.0	setget set_moreDotDamage
var finalDotDamage			= 0.0

func set_baseDotDamage (value):
	baseDotDamage = value
	final_DotDamage ()
	
func set_addDotDamage (value):
	addDotDamage = value
	final_DotDamage ()

func set_multiplyDotDamage (value):
	multiplyDotDamage = value
	final_DotDamage ()

func set_moreDotDamage (value):
	moreDotDamage = value
	final_DotDamage ()

func final_DotDamage ():
	finalDotDamage = ((baseDotDamage + addDotDamage) * multiplyDotDamage) * moreDotDamage

var baseDotDuration			= 1.0	setget set_baseDotDuration
var addDotDuration			= 0.0	setget set_addDotDuration
var multiplyDotDuration		= 1.0	setget set_multiplyDotDuration
var moreDotDuration			= 1.0	setget set_moreDotDuration
var finalDotDuration		= 0.0

func set_baseDotDuration (value):
	baseDotDuration = value
	final_DotDuration ()
	
func set_addDotDuration (value):
	addDotDuration = value
	final_DotDuration ()

func set_multiplyDotDuration (value):
	multiplyDotDuration = value
	final_DotDuration ()

func set_moreDotDuration (value):
	moreDotDuration = value
	final_DotDuration ()

func final_DotDuration ():
	finalDotDuration = ((baseDotDuration + addDotDuration) * multiplyDotDuration) * moreDotDuration

var baseCritChance			= 5.0	setget set_baseCritChance
var addCritChance			= 0.0	setget set_addCritChance
var multiplyCritChance		= 1.0	setget set_multiplyCritChance
var moreCritChance			= 1.0	setget set_moreCritChance
var finalCritChance			= 0.0

func set_baseCritChance (value):
	addCritChance = value
	final_CritChance ()
	
func set_addCritChance (value):
	addCritChance = value
	final_CritChance ()

func set_multiplyCritChance (value):
	multiplyCritChance = value
	final_CritChance ()

func set_moreCritChance (value):
	moreCritChance = value
	final_CritChance ()

func final_CritChance ():
	finalCritChance = ((baseCritChance + addCritChance) * multiplyCritChance) * moreCritChance

var baseCritMulti			= 150.0	setget set_baseCritMulti
var addCritMulti			= 0.0	setget set_addCritMulti
var multiplyCritMulti		= 1.0	setget set_multiplyCritMulti
var moreCritMulti			= 1.0	setget set_moreCritMulti
var finalCritMulti			= 0.0

func set_baseCritMulti (value):
	baseCritMulti = value
	final_CritMulti ()
	
func set_addCritMulti (value):
	addCritMulti = value
	final_CritMulti ()

func set_multiplyCritMulti (value):
	multiplyCritMulti = value
	final_CritMulti ()

func set_moreCritMulti (value):
	moreCritMulti = value
	final_CritMulti ()

func final_CritMulti ():
	finalCritChance = ((baseCritMulti + addCritMulti) * multiplyCritMulti) * moreCritMulti

var baseAttackSpeed			= 1.5	setget set_baseAttackSpeed
var addAttackSpeed			= 0.0	setget set_addAttackSpeed
var multiplyAttackSpeed		= 1.0	setget set_multiplyAttackSpeed
var moreAttackSpeed			= 1.0	setget set_moreAttackSpeed
var finalAttackSpeed		= 0.0

func set_baseAttackSpeed (value):
	baseAttackSpeed = value
	final_AttackSpeed ()
	
func set_addAttackSpeed (value):
	addAttackSpeed = value
	final_AttackSpeed ()

func set_multiplyAttackSpeed (value):
	multiplyAttackSpeed = value
	final_AttackSpeed ()

func set_moreAttackSpeed (value):
	moreAttackSpeed = value
	final_AttackSpeed ()

func final_AttackSpeed ():
	finalAttackSpeed = ((baseAttackSpeed + addAttackSpeed) * multiplyAttackSpeed) * moreAttackSpeed

var baseAreaOfEffect		= 1.0	setget set_baseAreaOfEffect
var addAreaOfEffect			= 0.0	setget set_addAreaOfEffect
var multiplyAreaOfEffect	= 1.0	setget set_multiplyAreaOfEffect
var moreAreaOfEffect		= 1.0	setget set_moreAreaOfEffect
var finalAreaOfEffect		= 0.0

func set_baseAreaOfEffect (value):
	baseAreaOfEffect = value
	final_AreaOfEffect ()
	
func set_addAreaOfEffect (value):
	addAreaOfEffect = value
	final_AreaOfEffect ()

func set_multiplyAreaOfEffect (value):
	multiplyAreaOfEffect = value
	final_AreaOfEffect ()

func set_moreAreaOfEffect (value):
	moreAreaOfEffect = value
	final_AreaOfEffect ()

func final_AreaOfEffect ():
	finalAreaOfEffect = ((baseAreaOfEffect + addAreaOfEffect) * multiplyAreaOfEffect) * moreAreaOfEffect

var baseProjectileSpeed		= 100.0	setget set_baseProjectileSpeed
var addProjectileSpeed		= 0.0	setget set_addProjectileSpeed
var multiplyProjectileSpeed	= 1.0	setget set_multiplyProjectileSpeed
var moreProjectileSpeed		= 1.0	setget set_moreProjectileSpeed
var finalProjectileSpeed	= 0.0

func set_baseProjectileSpeed (value):
	baseProjectileSpeed = value
	final_ProjectileSpeed ()
	
func set_addProjectileSpeed (value):
	addProjectileSpeed = value
	final_ProjectileSpeed ()

func set_multiplyProjectileSpeed (value):
	multiplyProjectileSpeed = value
	final_ProjectileSpeed ()

func set_moreProjectileSpeed (value):
	moreProjectileSpeed = value
	final_ProjectileSpeed ()

func final_ProjectileSpeed ():
	finalProjectileSpeed = ((baseProjectileSpeed + addProjectileSpeed) * multiplyProjectileSpeed) * moreProjectileSpeed

var baseProjectileSpread		= 15.0	setget set_baseProjectileSpread
var addProjectileSpread			= 0.0	setget set_addProjectileSpread
var multiplyProjectileSpread	= 1.0	setget set_multiplyProjectileSpread
var moreProjectileSpread		= 1.0	setget set_moreProjectileSpread
var finalProjectileSpread		= 0.0

func set_baseProjectileSpread (value):
	baseProjectileSpread = value
	final_ProjectileSpread ()
	
func set_addProjectileSpread (value):
	addProjectileSpread = value
	final_ProjectileSpread ()

func set_multiplyProjectileSpread (value):
	multiplyProjectileSpread = value
	final_ProjectileSpread ()

func set_moreProjectileSpread (value):
	moreProjectileSpread = value
	final_ProjectileSpread ()

func final_ProjectileSpread ():
	finalProjectileSpread = ((baseProjectileSpread + addProjectileSpread) * multiplyProjectileSpread) * moreProjectileSpread
