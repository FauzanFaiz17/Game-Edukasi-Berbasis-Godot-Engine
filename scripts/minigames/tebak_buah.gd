extends Control

@onready var question = $VBoxContainer/Pertanyaan
@onready var fruit_area = $VBoxContainer/FruitArea
@onready var buttons = $VBoxContainer/GridContainer.get_children()
@onready var audio_correct: AudioStreamPlayer = $AudioCorrect
@onready var audio_wrong: AudioStreamPlayer = $AudioWrong


@onready var popup = $ResultPopup
@onready var result_text = $ResultPopup/Panel/VBoxContainer/ResultText
@onready var btn_next = $ResultPopup/Panel/VBoxContainer/HBoxContainer/BtnNext
@onready var btn_menu = $ResultPopup/Panel/VBoxContainer/HBoxContainer/BtnMenu

var level := 1
var max_level := 5
var score := 0

var correct_answer := 0
var fruits = [
	{
		"name": "apel",
		"texture": preload("res://assets/fruits/apel.png")
	},
	{
		"name": "pisang",
		"texture": preload("res://assets/fruits/pisang.png")
	},
	{
		"name": "anggur",
		"texture": preload("res://assets/fruits/fruit.png")
	}
]

func _ready():
	level = Global.saved_level
	popup.visible = true
	btn_next.pressed.connect(_on_next_pressed)
	btn_menu.pressed.connect(_on_menu_pressed)
	start_level()

# =========================
# LEVEL SYSTEM
# =========================
func start_level():
	popup.visible = false
	clear_fruits()

	var fruit_data = fruits[level % fruits.size()]
	correct_answer = randi_range(1, 3 + level)

	question.text = "Ada berapa %s?" % fruit_data.name

	generate_fruits(correct_answer, fruit_data.texture)
	generate_answers(correct_answer)

# =========================
# FRUITS
# =========================
func generate_fruits(amount: int, texture: Texture2D):
	for i in amount:
		var fruit = TextureRect.new()
		fruit.texture = texture
		fruit.custom_minimum_size = Vector2(64, 64)
		fruit.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		fruit_area.add_child(fruit)



func clear_fruits():
	for child in fruit_area.get_children():
		child.queue_free()

# =========================
# ANSWERS
# =========================
func generate_answers(correct: int):
	var answers = [
		correct,
		correct + 1,
		max(1, correct - 1)
	]
	answers.shuffle()

	for i in buttons.size():
		var btn = buttons[i]

		btn.text = str(answers[i])

		var callable = Callable(self, "_on_answer_pressed").bind(answers[i])

		if btn.pressed.is_connected(callable):
			btn.pressed.disconnect(callable)

		btn.pressed.connect(callable)


# =========================
# ANSWER CLICK
# =========================
func _on_answer_pressed(value: int):
	if value == correct_answer:
		audio_correct.play()
		show_popup(true)
	else:
		audio_wrong.play()
		show_popup(false)


# =========================
# POPUP
# =========================
func show_popup(is_correct: bool):
	popup.visible = true

	if is_correct:
		result_text.text = "Benar! 🎉"
		btn_next.visible = true
	else:
		result_text.text = "Salah 😢"
		btn_next.visible = false

# =========================
# BUTTONS
# =========================
func _on_next_pressed():
	if level < max_level:
		level += 1
		Global.saved_level = level
		start_level()
	else:
		show_finish()

func show_finish():
	result_text.text = "🎉 Semua level selesai!"
	btn_next.visible = false


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
