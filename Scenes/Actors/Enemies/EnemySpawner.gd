extends Node2D

#spawning circle animation that shrinks over 2-3 secs

onready var timer = get_node("Timer")
var difficulty				= 60 #default = 60, difficulty +1 every minute
export var spawnResources	= 1.0

func _process(delta):
	spawnResources += delta/difficulty
func _ready():
	timer.set_one_shot(true)
	timer.connect("timeout", self, "create_spawn_array")
	create_spawn_array()

func enemy_spawn_cooldown(value):
	timer.set_wait_time(value)
	timer.start()

func create_spawn_array():
	#create an array of enemy indices that have maxIndex = spawnResources

	var enemyType: int	= rand_range(1.0, spawnResources)# warning-ignore:narrowing_conversion
	var enemyCount		= randi() %5 +1
	var enemyCooldown	= rand_range(2.0, 5.0)
	var spawnArray = []

	enemy_spawn_cooldown(enemyCooldown)# wait until next wave

	for i in enemyCount:
		spawnArray.append(enemyType)
	print(enemyCooldown, " ",spawnArray)
	return spawnArray
	

func spawn_enemies(value: Array):
	#gets an array of a couple enemies and spawns the correct type at a given position, (making sure they are grouped correctly) -> might be fixed by giving enemy logic to stay away from other enemies
	pass
