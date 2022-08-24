extends CanvasLayer
var pauseUIStatsRes	= load ("res://Resources/UIRes/PauseUIStatsRes.tres")

#var startMenu		= preload ("res://Scenes/UI/StartMenu.tscn")
var quitConfirm		= preload ("res://Scenes/UI/ConfirmationDialogue.tscn")
var settingsScene	= preload ("res://Scenes/UI/SettingsMenu.tscn")
var confirmNode

func _ready():
	self.visible = pauseUIStatsRes.isPaused

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		handle_pausing ()

func paused_state_changer ():
	pauseUIStatsRes.isPaused = !pauseUIStatsRes.isPaused
	self.set_visible (pauseUIStatsRes.isPaused)
	self.get_tree().paused = pauseUIStatsRes.isPaused

func handle_pausing ():
	if pauseUIStatsRes.isPaused == false:
		if pauseUIStatsRes.windowOnTop == false:
			paused_state_changer ()
		else:
			pauseUIStatsRes.windowOnTop = false
	elif pauseUIStatsRes.isPaused == true and pauseUIStatsRes.windowOnTop == false:
		paused_state_changer ()

func _on_SettingsButton_pressed():
	add_child(settingsScene.instance())
	pauseUIStatsRes.windowOnTop = true

func _on_QuitButton_pressed():
	var quitScene
	quitScene = quitConfirm.instance()
	quitScene.topicText = "Quit the Run?"
	quitScene.descriptionText = "Your Progress will be lost!"
	add_child(quitScene)
	yield (get_tree().create_timer(0.01), "timeout")
	confirmNode = get_node ("ConfirmationDialogue")
	confirmNode.confirmButton.connect ("button_up", self, "confirmation_dialogue_confirmed")
	pauseUIStatsRes.windowOnTop = true

func confirmation_dialogue_confirmed():
	get_tree().change_scene("res://Scenes/UI/StartMenu.tscn")
