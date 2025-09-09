class_name MainMenu extends Control


var main_scene = preload("res://scenes/main.tscn").instantiate()

@onready var start_button: Button = $%StartButton
@onready var options_button: Button = $%OptionsButton
@onready var exit_button: Button = $%ExitButton


func _ready() -> void:
	start_button.pressed.connect(on_start_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)
	
	
func on_start_button_pressed():
	get_tree().root.add_child(main_scene)
	queue_free()
	

func on_options_button_pressed():
	print("Hello from options")


func on_exit_button_pressed():
	get_tree().quit()
	
