extends Control

@export var character_id: String
@export var character_name: String
@export var character_texture: Texture2D

@onready var image = $Panel/VBoxContainer/CharacterImage
@onready var name_label = $Panel/VBoxContainer/CharacterName
@onready var btn_select = $Panel/VBoxContainer/BtnSelect

func _ready():
	image.texture = character_texture
	name_label.text = character_name
	btn_select.text = "Main"

	btn_select.pressed.connect(_on_select_pressed)

func _on_select_pressed():
	Global.selected_character = character_id
	print("Karakter dipilih:", character_id)
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
