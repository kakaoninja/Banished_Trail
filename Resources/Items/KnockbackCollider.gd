extends BaseItem

onready var collider = player.get_node ("Knockback")
"""
func collide ():
	add_child (Lightning.instance())
	PushCollider.visible = true
	PushTimer.wait_time = 0.5
	PushTimer.timeout()
	PushCollider.visible = false
"""
