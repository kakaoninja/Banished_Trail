extends TextureRect

func _process(delta):
	if self.rect_position != Vector2(0, 0):
		self.rect_position = Vector2(0, 0)
