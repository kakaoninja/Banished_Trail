extends Label



func _on_MasterVolumeSlider_value_changed(value: float) -> void:
	self.set_text(str(value))
