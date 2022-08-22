extends Control



onready var optionsMenu	= get_node("OptionsMenu")
onready var pauseIcon	= get_node("PauseIcon")


var isPaused	= false setget set_is_paused
var isVisible	= false setget set_options_visible

func _ready():
	#optionsMenu.connect("hide", self, "set_isVisible_false")
	pause_mode = Node.PAUSE_MODE_PROCESS
	pauseIcon.hide()
	set_options_visible(false)
	self.hide()
	print("PauseUIReady")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"): #and get_tree().current_scene.name == "Main":
		if isVisible == true:
			set_options_visible(false)
		elif isVisible == false:
			self.isPaused = !isPaused

func set_is_paused(value):
	isPaused = value
	self.visible 		= isPaused
	get_tree().paused	= isPaused
	pauseIcon.visible	= isPaused

func set_options_visible(value: bool):
	isVisible = value
	optionsMenu.set_visible(value)

func set_isVisible_false():
	isVisible = false
