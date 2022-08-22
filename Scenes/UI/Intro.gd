extends Control

func _input(event) -> void:
	if event is InputEventKey:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/StartMenu.tscn")
		pass

func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
	pass
