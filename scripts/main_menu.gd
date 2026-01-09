extends Control

@onready var settings_popup_scene = preload("res://ui/settings_popup.tscn")

var settings_popup

func _ready():
	$Center/BtnMain.pressed.connect(_on_main_pressed)
	$Center/BtnSettings.pressed.connect(_on_settings_pressed)

func _on_main_pressed():
	get_tree().change_scene_to_file(
		"res://scenes/character_select.tscn"
	)
func _on_settings_pressed():
	if settings_popup == null:
		settings_popup = settings_popup_scene.instantiate()
		add_child(settings_popup)
