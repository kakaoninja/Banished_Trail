extends CanvasLayer

func _input(event) -> void:
	if event is InputEventKey:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/UI/StartMenu.tscn")
		pass

func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/UI/StartMenu.tscn")
	pass
