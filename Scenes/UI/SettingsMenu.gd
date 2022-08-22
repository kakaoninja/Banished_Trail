extends Control

export var audio_bus_name := "Master"
onready var _bus := AudioServer.get_bus_index(audio_bus_name) #get index
var volume

func _ready() -> void:
	#OS.set_window_borderless(!OS.window_borderless)
	volume = db2linear(AudioServer.get_bus_volume_db(_bus))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		self.queue_free()

func _on_Fullscreen_toggled(button_pressed: bool) -> void:
	OS.set_window_fullscreen(!OS.window_fullscreen)
	if button_pressed == false and OS.is_window_resizable():
		#OS.set_window_resizeable(true)
		pass

func _on_BloomSlider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_MasterVolumeSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus ,value)


func _on_MusicVolumeSlider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_SoundVolumeSlider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_Button_pressed() -> void:
	self.queue_free()
