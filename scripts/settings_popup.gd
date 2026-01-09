extends Control

@onready var music_slider = $Panel/VBox/VolumeSlider


func _ready():
	print("SettingsPopup muncul")

	music_slider.min_value = 0.0
	music_slider.max_value = 1.0
	music_slider.step = 0.01
	music_slider.value = 1.0

	music_slider.value_changed.connect(_on_music_slider_changed)
	$Panel/VBox/BtnClose.pressed.connect(_on_close_pressed)

func _on_music_slider_changed(value: float):
	AudioManager.set_music_volume(value)

func _on_close_pressed():
	queue_free()
