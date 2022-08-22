extends Node2D

export var selectedWeapon = 1

var weapons= []
func _ready() -> void:
	weapons = get_children() #array of Children Nodes
	set_current_weapon()
	
func set_current_weapon():
	var NodeIndex
	for weapon in weapons: #hide all
		weapon.hide()
	NodeIndex = weapons[selectedWeapon]
	NodeIndex.show()

