extends Sprite

var playerStatsRes = load ("res://Resources/PlayerStatsRes.tres")

var playerPosTranslation
var shaderPos

#func _process(delta):
#	material.set_shader_param ("player_position", playerStatsRes.playerPosition / 960 * Vector2(0.5, 0.5))
