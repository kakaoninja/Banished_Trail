extends Control
onready var metaHover = load ("res://Resources/MetaHoverItems/MetaHoverResource.tres")
onready var metaHoverLabel = preload ("res://Resources/MetaHoverItems/MetaHoverTooltip.tscn")
onready var animationRes = load ("res://Resources/Graphs/AnimationTime.tres")

onready var animPlayer =	get_node ("AnimationPlayer")
onready var sprite =		get_node ("Sprite")
onready var label =			get_node ("CharacterStatDisplay")
onready var button = 		get_node ("SelectButton")
onready var parent = 		get_node ("MetaParent")
onready var charselect=		get_parent().get_parent()



var pos: Array = []
var xmargin = 10
var ymargin = 8
var texture
var outside: bool
#var tooltip = ["stoopid\n", "redicolous\n", "[url]tedious[/url]\n"]
var tooltip : Array
var professionID
signal button_was_pressed
#--------------------
func _ready():
	animationRes.animationSpeed = animPlayer.playback_speed
	button.connect ("button_up", self, "button_pressed")
# warning-ignore:return_value_discarded
	self.connect ("button_was_pressed", charselect, "handle_button_pressed")

	button.connect ("mouse_entered", self, "event_mouse_entered")
	button.connect ("mouse_exited", self, "event_mouse_exited")
	label.connect ("meta_hover_started", self, "signal_meta_hover_started")
	label.connect ("meta_hover_ended", self, "signal_meta_hover_ended")

	event_mouse_exited ()
	sprite.set_texture (texture)
	if tooltip != null:
		add_text(tooltip)

func _process(_delta):
	mouse_exited_hover_word()
#--------------------
#handle signals
func add_text (text):
	#character description & passives
	for i in text.size():
		label.append_bbcode(text[i])

func event_mouse_entered ():
	animPlayer.play ("Run")

func event_mouse_exited ():
	animPlayer.play ("Idle")
	animPlayer.advance (animationRes.animationTime)

func signal_meta_hover_started(meta):
	outside = false
	pos.append (get_global_mouse_position())
	metaHover.create_tooltip (parent, meta, metaHoverLabel)

func signal_meta_hover_ended (_ignore):
	outside = true
#--------------------
#remove jitter from label

func mouse_exited_hover_word ():
	if parent.get_child_count() > 1:
		meta_hover_ended()
	elif parent.get_child_count() == 1 and outside == true:
		if get_global_mouse_position().x > pos[0].x + xmargin:
			meta_hover_ended ()
			return
		if get_global_mouse_position().x < pos[0].x - xmargin:
			meta_hover_ended ()
			return
		if get_global_mouse_position().y > pos[0].y + ymargin:
			meta_hover_ended ()
			return
		if get_global_mouse_position().y < pos[0].y - ymargin:
			meta_hover_ended ()
			return

func meta_hover_ended ():
	pos.pop_front()
	parent.get_child (0).queue_free ()

func button_pressed ():
	emit_signal ("button_was_pressed", professionID)
