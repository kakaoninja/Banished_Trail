extends Control
onready var playerStats = load ("res://Resources/PlayerStats.tres")

onready var levelUp			= get_node ("levelUp")
onready var xpUp			= get_node ("xpUp")

onready var lvlLabel		= get_node ("levelLabel")
onready var nextLvlLabel	= get_node ("nextLevelLabel")

func _ready():
	levelUp.connect		("button_down", self, "do_level_up")
	xpUp.connect		("button_down",self , "do_xp_up")
	
	playerStats.connect	("level_up", self, "level_label_text")
	playerStats.connect	("xp_gained", self, "got_xp_gained")
	playerStats.connect	("xp_to_next_level", self, "got_xp_to_next")

	playerStats.calc_next_xp_level (playerStats.level)

	level_label_text	(playerStats.level)
	xp2next_label_text	(playerStats.experience, playerStats.xpToNextLevel)
	#test_xp_steps (50)
	

func test_xp_steps (value):
	for i in value:
		print (playerStats.calc_next_xp_level (i))

func level_label_text (value):
	lvlLabel.text	= str (value + 1)

func got_xp_gained (xp):
	xp2next_label_text (xp, playerStats.xpToNextLevel)
func got_xp_to_next (xp2next):
	xp2next_label_text (playerStats.experience, xp2next)


func xp2next_label_text (xp, xp2next):
	nextLvlLabel.text	= str (int(xp), "/", int(xp2next))

func do_level_up ():
	print("levelUp")
	playerStats.set_level (5)

func do_xp_up ():
	print("xpUp")
	playerStats.set_experience (5)
