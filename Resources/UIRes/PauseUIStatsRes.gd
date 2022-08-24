extends Resource
class_name PauseUIStatsRes

var windowOnTop: bool = false
var isPaused: bool = false

func queue_free_self (node):
	node.queue_free()
