extends Control
onready var professionRes = load ("res://Resources/Professions/Profession.tres")
onready var animationRes = load ("res://Resources/Graphs/AnimationTime.tres")

onready var charSelectButton = preload ("res://Scenes/Pregame/CharacterSelection/CharacterSelectionButton.tscn")
onready var hBox = get_node ("HBox")

func _ready():
	create_buttons()
	print (professionRes.profession_dict["dictEmergency"])
	print (professionRes.profession_dict["dictRage"][3])

func _process(delta):
	animationRes.calc_animationTime (delta, 0.5)

func create_buttons ():
	var keyList = professionRes.profession_dict.keys ()
	for i in (professionRes.profession_dict.size () - 1):
		var dictKey = keyList [i]
		var professionIdentifier = professionRes.profession_dict[dictKey][0]
		var newButton = charSelectButton.instance ()
		newButton.tooltip = professionIdentifier
		var texture = professionRes.profession_dict[dictKey][2]
		newButton.professionID = dictKey
		newButton.texture = texture
		hBox.add_child(newButton)


#--------------------
#handle button pressed - set correct profession

func handle_button_pressed (professionIdentifier):
	professionRes.professionID = professionIdentifier
	pass
