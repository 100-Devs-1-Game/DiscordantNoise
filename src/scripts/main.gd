class_name Main extends Node

@export var menu_ui: MenuUIController


func _ready() -> void:
	Conductor.notifier.running = true
	GameEvents.died.connect(on_died)
	add_to_group("main")


func on_died():
	get_tree().quit()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		menu_ui.pause_game()
