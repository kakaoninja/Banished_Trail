extends Control

onready var quitConfirm	= get_node("ConfirmationDialog")

func _on_SettingsButton_pressed() -> void:
	pass
	#add_child


func _on_QuitButton_pressed() -> void:
	quitConfirm.popup()


func _on_ConfirmationDialog_confirmed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/StartMenu.tscn")

