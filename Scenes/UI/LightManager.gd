extends TextureRect

onready var ShieldGlow		= preload ("res://Scenes/UI/Lights/ShieldGlow.tscn")
onready var CoreGlow		= preload ("res://Scenes/UI/Lights/CoreGlow.tscn").instance()
onready var ShieldsTexture	= get_node ("currentShieldsUI")
onready var CoreTexture		= get_node ("currentCoresUI")

func _process(delta):
	if CoreTexture.rect_size.x > 0: #FIXME call once, set pos
		CoreTexture.add_child(CoreGlow)
	if CoreTexture.rect_size.x == 0:
		for i in CoreTexture.get_children():
			CoreTexture.remove_child(i)
