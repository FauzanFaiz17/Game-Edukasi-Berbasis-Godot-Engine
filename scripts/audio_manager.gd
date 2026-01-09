extends Node

var bgm_player: AudioStreamPlayer

func _ready():
	set_music_volume(1.0)
	bgm_player = AudioStreamPlayer.new()
	bgm_player.stream = preload("res://assets/music/50 Cent - Candy Shop (Onderkoffer Remix) [EqpKBL1YMms].mp3")
	bgm_player.autoplay = false
	bgm_player.bus = "Music"
	add_child(bgm_player)

	bgm_player.play()

func set_music_volume(value: float):
	# value 0.0 – 1.0
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		db
	)
