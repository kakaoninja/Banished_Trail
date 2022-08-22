extends Node

enum Character	{
	BUTCHER,
	FASTFRAGGER,
	INFERNALIST,
	PLAGUEBREAKER,
	SHADOWSLASHER
}
enum Weapon		{
	BOW,
	CROSSBOW,
	DAGGER,
	HAMMER,
	SHIELD,
	STAFF,
	SWORD,
	WAND
}
enum Skill		{
	SKILL1,
	SKILL2,
	SKILL3
}

export var selectedCharacter 	= 1
export var selectedWeapon	 	= 1
export var selectedSkill	 	= 1

func set_selected_character():
	pass

func set_selected_weapon():
	pass

func set_selected_skill():
	pass
