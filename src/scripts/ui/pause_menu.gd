class_name PauseMenu extends Control


@onready var resume_button: Button = $%ResumeButton
@onready var options_button: Button = $%OptionsButton
@onready var exit_button: Button = $%ExitButton


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)


func on_resume_button_pressed():
	GameEvents.resume()
	queue_free()
	

func on_options_button_pressed():
	pass


func on_exit_button_pressed():
	GameEvents.exit_game()
	pass
