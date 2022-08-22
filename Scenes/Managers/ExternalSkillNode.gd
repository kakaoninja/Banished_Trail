extends Node2D
var weaponSkillsRes = load ("res://Resources/WeaponSkills/Dagger/DaggerThrowRes.tres")
var weaponPath = load ("res://Scenes/Weapons/Skills/DaggerThrow.tscn")
#var weaponSkillsRes = load ("res://Resources/WeaponSkills/Dagger/DaggerStormRes.tres")
#var weaponPath = load ("res://Scenes/Weapons/Skills/DaggerStorm.tscn")
#this needs to be set with skill select screen

var playerStatsRes = load ("res://Resources/PlayerStatsRes.tres")

onready var attackSpeedTimer = get_node ("AttackSpeedCooldown")

func _ready():
	weaponSkillsRes.add_parent_to_groups (self, weaponSkillsRes.groups)
	weaponSkillsRes.set_base_stats (playerStatsRes)
	if self.is_in_group("CIRCULAR") and self.is_in_group ("STATIONARY"):
		playerStatsRes.connect ("got_projectiles", self, "spawn_circular")
		spawn_circular ()
	if self.is_in_group("ATTACKSPEED") and self.is_in_group("PROJECTILE"):
		attackSpeedTimer.connect ("timeout", self, "attack_speed_timer_timeout")
		attackSpeedTimer.set_paused (false)
		attackSpeedTimer.start (1 / playerStatsRes.finalAttackSpeed)
	print (self.get_groups())

func attack_speed_timer_timeout ():
	weaponSkillsRes.attack_speed_timer (attackSpeedTimer)
	weaponSkillsRes.skill_spawner (self, weaponPath)

func spawn_circular ():
	weaponSkillsRes.skill_spawner (self, weaponPath)
