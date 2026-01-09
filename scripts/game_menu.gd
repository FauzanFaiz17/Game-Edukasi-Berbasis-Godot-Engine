extends Control

@onready var character_image = $Background/VBoxContainer/Header/CharacterPreview
@onready var title_label = $Background/VBoxContainer/Header/NamaCharacter
@onready var btn_tebak_buah = $Background/VBoxContainer/MiniGameGrid/BtnTebakBuah

func _ready():
	btn_tebak_buah.pressed.connect(_on_tebak_buah_pressed)

	title_label.text = "Halo, " + Global.selected_character.capitalize()

	match Global.selected_character:
		"harimau":
			character_image.texture = preload("res://assets/character/harimau.png")
		"serigala":
			character_image.texture = preload("res://assets/character/sriga.png")
		"buaya":
			character_image.texture = preload("res://assets/character/buay.png")

func _on_tebak_buah_pressed():
	get_tree().change_scene_to_file("res://scenes/mini_games/tebak_buah.tscn")
