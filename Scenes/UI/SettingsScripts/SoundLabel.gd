extends Label



func _on_SoundVolumeSlider_value_changed(value: float) -> void:
	self.set_text(str(value))
