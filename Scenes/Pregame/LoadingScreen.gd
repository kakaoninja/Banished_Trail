extends CanvasLayer
var playerStatsRes: PlayerStatsRes = load ("res://Resources/PlayerStatsRes.tres")

onready var particleInit = load ("res://Scenes/Pregame/ParticlesInitializer.tscn")


signal all_nodes_ready

func _ready():
	add_child(particleInit.instance())
	var particleInitNode = get_node ("ParticlesInitializer")
	playerStatsRes.precalc_stats ()
	particleInitNode.connect ("particlesInitialized", self, "loader")

func loader ():
	loading_finished()

func loading_finished ():
	emit_signal ("all_nodes_ready")
	self.queue_free()
