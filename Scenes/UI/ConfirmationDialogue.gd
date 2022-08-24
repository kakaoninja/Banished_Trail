extends CanvasLayer

var pauseUIStatsRes = load ("res://Resources/UIRes/PauseUIStatsRes.tres")

var topicText
var descriptionText

onready var topicLable			= get_node ("CenterContainer/ContentBox/TopicLabel")
onready var descriptionLabel	= get_node ("CenterContainer/ContentBox/DescriptionLabel")
onready var confirmButton		= get_node ("CenterContainer/ContentBox/buttonSep/ConfirmButton")
onready var panel				= get_node ("CenterContainer/Panel")
onready var contentBox			= get_node ("CenterContainer/ContentBox")

func _ready():
	pauseUIStatsRes.windowOnTop = true
	if topicText != null:
		topicLable.text = topicText
	if descriptionText != null:
		descriptionLabel.text = descriptionText
	panel.rect_min_size.y = contentBox.rect_size.y + 16

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		pauseUIStatsRes.queue_free_self (self)

func _on_cancel_button_up():
	pauseUIStatsRes.queue_free_self (self)
	pauseUIStatsRes.windowOnTop = false
