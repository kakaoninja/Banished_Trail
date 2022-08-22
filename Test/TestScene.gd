extends Node2D

"""
# 1.

var spawnResources	= 5
var spawnArray		= []
var difficulty		= 2
func _ready ():
	var enemyType
	while spawnResources  >= 0:
		if spawnResources <= 10:
			enemyType = 1
		else:
			enemyType = max (difficulty, int(spawnResources * sqrt(randf()) ))
		spawnResources -= enemyType
		spawnArray.append (enemyType)
	print (spawnArray)
"""

# 2.

enum BaseTypes {
	NORMY,
	SPEEDY,
	SHOOTY,
	TANKY,
	SPAWNY,
}

func _process (delta):
	var test = randi () % 10 + 1
	enemy_type (test)
	print ("Test: ", test, "Result: ", enemy_type (test) )

func enemy_type (undefined):
	# calculate enemyType based on divideable by #BaseType
	for i in BaseTypes.size ():
		if undefined % (5 - i) == 0: # i = 01234 // check highest first // 5-i -> 54321
			return (5 - i)
