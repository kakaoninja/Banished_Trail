extends CanvasLayer
var pauseUIStatsRes	= load ("res://Resources/UIRes/PauseUIStatsRes.tres")

#var startMenu		= preload ("res://Scenes/UI/StartMenu.tscn")
var hoverHint		= preload ("res://Resources/MetaHoverItems/MetaHoverTooltip.tscn")
var quitConfirm		= preload ("res://Scenes/UI/ConfirmationDialogue.tscn")
var settingsScene	= preload ("res://Scenes/UI/SettingsMenu.tscn")
onready var itemsHelp	= get_node ("QuestItemsHelp")
onready var tweenNode	= get_node ("TweenNode")
var confirmNode
var itemsHelp_endPosition	= Vector2 (460, 24)
var itemsHelp_startPosition	= Vector2 (232, 127)
var animationFinished = false


func _ready():
	self.visible = pauseUIStatsRes.isPaused
	itemsHelp.rect_position = itemsHelp_startPosition
	itemsHelp.rect_scale = Vector2 (3, 3)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		handle_pausing ()
		if animationFinished == false:
			yield (get_tree().create_timer(0.3), "timeout")
			tweenNode.interpolate_property (itemsHelp, "rect_scale", Vector2 (3, 3), Vector2 (1, 1), 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
			tweenNode.interpolate_property (itemsHelp, "rect_position", itemsHelp_startPosition ,itemsHelp_endPosition, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
			tweenNode.start ()
			animationFinished = true

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


func _on_QuestItemsHelp_mouse_entered():
	var tooltip = hoverHint.instance()
	tooltip.tooltipText = """This list shows the available Questitems of your completed Quests.
Drag and drop them into the "Inventory" below for them to take effect.
You can swap them out at any point in the run, depending on what suits your current skill best."""
	add_child (tooltip)


func _on_QuestItemsHelp_mouse_exited():
	var tooltipDelete = get_node("MetaHoverTooltip")
	tooltipDelete.queue_free()
