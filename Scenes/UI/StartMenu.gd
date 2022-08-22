extends Control

func _on_Start_pressed() -> void:
	pass # Replace with function body.

func _on_Items_pressed() -> void:
	pass # Replace with function body.

func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _on_SettingsButton_pressed() -> void:
	var settingsMenu = preload("res://Scenes/UI/SettingsMenu.tscn").instance()
	add_child(settingsMenu)
