extends CanvasLayer

export (Resource) var playerStatsRes  = load ("res://Resources/PlayerStatsRes.tres")

var energyLevel		= 0.0
var energyStacks	= 0.0

export (Curve) var smoothPulse
onready var smoothPulseRES = preload ("res://Resources/Graphs/pulseCurve.tres")

onready var maxCoresUI =		get_node ("center/maxCoresUI")
onready var currentCoresUI =	get_node ("center/maxCoresUI/currentCoresUI")
onready var currentShieldsUI =	get_node ("center/maxCoresUI/currentShieldsUI")

onready var emergencyLineUI =	get_node ("center/maxCoresUI/emergencyLineUI")
onready var emergencyCoreUI =	get_node ("center/maxCoresUI/emergencyCoreUI")

onready var ShieldsGlow		= preload ("res://Scenes/UI/Lights/ShieldGlow.tscn")
onready var CoresGlow		= preload ("res://Scenes/UI/Lights/CoreGlow.tscn")

func _ready():
	playerStatsRes.connect ("current_shields_changed", self, "ui_current_shields_changed")
	playerStatsRes.connect ("current_cores_changed", self, "ui_current_cores_changed")
	playerStatsRes.connect ("max_cores_changed", self, "ui_max_cores_changed")
	smoothPulse = smoothPulseRES
	emergencyCoreUI.visible = false
	emergencyLineUI.visible = false

func _process(delta):
	energyCurve (delta)

func energyCurve (delta):
	energyStacks += delta / 2
	energyLevel = self.smoothPulse.interpolate_baked (energyStacks)
	if energyStacks > 1.0:
		energyStacks -= 1.0

func ui_current_shields_changed (currentShields):
	"""
	if currentShields == 0:
		currentShieldsUI.visible = false
	else:
		currentShieldsUI.visible = true
	"""
	#add and remove lights
	var shieldsChildren = currentShieldsUI.get_children()
	for i in shieldsChildren:
		i.queue_free()
	for i in currentShields:
		var ShieldsGlowInstance = ShieldsGlow.instance()
		ShieldsGlowInstance.set_position (Vector2 ((16 + (i * 32)), 16))
		currentShieldsUI.add_child (ShieldsGlowInstance)
	"""
	if currentShields * 32 > currentShieldsUI.rect_min_size.x:
		var ShieldsGlowInstance = ShieldsGlow.instance()
		ShieldsGlowInstance.set_position (Vector2 ((16 + (currentShields -1) * 32), 16))
		currentShieldsUI.add_child (ShieldsGlowInstance)
	if currentShields * 32 < currentShieldsUI.rect_min_size.x:
		var shieldsChildren = currentShieldsUI.get_children()
		var shieldsLastChild = shieldsChildren.pop_back()
		currentShieldsUI.remove_child (shieldsLastChild)
	"""

	currentShieldsUI.rect_min_size.x = 32 * currentShields

func ui_current_cores_changed(currentCores):
	if currentCores == 1:
		emergency_mode (true)
	else:
		emergency_mode (false)
	# add and remove lights
	var coresChildren = currentCoresUI.get_children()
	for i in coresChildren:
		i.queue_free()
	for i in currentCores:
		var CoresGlowInstance = CoresGlow.instance()
		CoresGlowInstance.set_position (Vector2 ((16 + (i * 32)), 16))
		currentCoresUI.add_child (CoresGlowInstance)
	"""
	if currentCores *32 > currentCoresUI.rect_min_size.x:
		var CoresGlowInstance = CoresGlow.instance()
		CoresGlowInstance.set_position (Vector2 ((16 + (currentCores-1) * 32), 16))
		currentCoresUI.add_child (CoresGlowInstance)
	if currentCores * 32 < currentCoresUI.rect_min_size.x:
		var coresChildren = currentCoresUI.get_children()
		var coresLastChild = coresChildren.pop_back()
		currentCoresUI.remove_child (coresLastChild)
	"""

	currentCoresUI.rect_min_size.x = 32 * currentCores

func ui_max_cores_changed(maxCores):
	maxCoresUI.rect_min_size.x = 32 * maxCores

func emergency_mode (active):
	currentCoresUI.visible = !active
	emergencyCoreUI.visible = active
	emergencyLineUI.visible = active
