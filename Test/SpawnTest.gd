extends Node
var tilesetSize = 16 #FIXME, this needs to be in pathfinding

enum BaseTypes {
	NORMY,
	SPEEDY,
	SHOOTY,
	TANKY,
	SPAWNY,
}


#FIXME
onready var REStestEnemy = preload ("res://Scenes/Actors/Enemies/EnemyBase.tscn")

onready var timer = get_node ("Timer")

export var spawnResources	= 4.0
export var timeScaling		= 0.0
export var rawTime			= 0.0
var difficulty				= 1.3 #determines the base difficulty of the game

func _ready ():
	randomize()
	timer.set_one_shot (true)
	timer.connect ("timeout", self, "create_spawn_array")
	create_spawn_array ()

func _process (delta):
	rawTime			+= delta
	timeScaling		+= delta/60
	spawnResources	+= delta * difficulty * (timeScaling + 1)

func enemy_spawn_cooldown(waitTime):
	timer.set_wait_time(waitTime)
	timer.start()

func create_spawn_array ():
#create an array of enemy indices that have sumIndex = spawnResources
# warning-ignore:narrowing_conversion
	var enemyType: int
	var enemyCooldown	= rand_range (1.0, 5.0)
	var spawnArray		= []

	enemy_spawn_cooldown (enemyCooldown)# wait until next wave
	#print ("Resources: ", int(spawnResources))
	#loop creating enemyType each time
	while spawnResources  >= 0:
		spawnResources -= enemyType
		enemyType = create_enemy_types()
		spawnArray.append (enemyType)

	FIXME_TEST_SPAWNER(spawnArray.size())



	#print ("Time: ", int (rawTime), " Difficulty: ", int (timeScaling), " ",spawnArray)
	#spawn_enemies (spawnArray)
	

func create_enemy_types ():
	# highest enemy should only be the current difficulty, to introduce enemies one at a time
	return int (timeScaling * pow (randf(), 5) + 1 + timeScaling / 4) 

#func mid_game ():
#	# introduce buffs and toughness modifiers
#	pass
#func end_game ():
#	# stack it all up
#	# minimum 11
#	pass


func spawn_enemies (spawn: Array):
	# spawn logic for the different stages of the game // make sure enemies get their correct modifiers at higher difficulties
	var spawnAmount = spawn.size()
	for i in spawn.size ():
		var enemyType
		var individual
		individual	= spawn.pop_back()
		enemyType	= enemy_type (individual)
	#enemy_spawn_position(spawnAmount)

func enemy_type (undefined):
	# calculate enemyType based on divideable by #BaseType
	var l = BaseTypes.size ()
	for i in l:
		if undefined % (l - i) == 0: # i = 01234 // check highest first // 5-i -> 54321
			return (l - i)

func enemy_spawn_position (amountEnemies):
	# spawn enemies grouped at random positions
	var spawnPositions = []
	# i need to find valid tiles to spawn, placeholder = validTilesFIXME
	var validTilesFIXME = []
	# pick a random 6x6 spot on the tilemap to group the enemie spawn area// needs to be calc in pathfinderFIXME // this should be a vec2 array with 36 integers, missing if invalid area (...2,3,5,8,9...)
	for i in amountEnemies:
		# pick spots in nearby  VALIDtilesets  to populate

		var tempPosition = [
			validTilesFIXME[randi () % validTilesFIXME + 1],
			Vector2 (randi () % tilesetSize + 1 , randi ()% tilesetSize + 1)
			]

		spawnPositions.append(tempPosition)
		pass
	pass
	return (spawnPositions)

#different functions for different states of the game. early game should have no enemies that are tougher than normal
#func early_spawn (array: Array):
#	pass

#func mid_spawn (array: Array):
#	# midgame should introduce a couple sporadic buffs here and there with some more tougher enemies
#	pass
#
#func end_spawn (array: Array):
#	# endgame is where we go crazy and do buff and toughness stacking
#	pass


var MapSize = Vector2 (600, 400) # FIXME

func FIXME_TEST_SPAWNER(amountEnemies):
	for i in amountEnemies:
		var tempPosition = Vector2 (randi () % int (MapSize.x) + (1 - MapSize.x / 2) , randi ()% int (MapSize.y) + (1 - MapSize.y / 2))
		var testEnemy = REStestEnemy.instance()
		testEnemy.add_to_group("Enemies")
		testEnemy.set_position (tempPosition)
		add_child(testEnemy)
