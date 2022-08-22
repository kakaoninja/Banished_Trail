extends Resource
class_name ItemManager

onready var player = ("%Player")
onready var WeaponSkill		= player.get_node ("BaseWeapon").get_child (0)
#onready var Profession		= get_node	("Profession")


func item_tags ():
	var tagsArray = []
	for i in WeaponSkill.get_groups():
		tagsArray.append (i)
	#print (tagsArray)
	"""
	for i in Profession.get_groups():
		tagsArray.append (i)
	#print (tagsArray)
	"""
	for i in tagsArray:
		player.add_to_group (i)
	#print (self.get_groups())
