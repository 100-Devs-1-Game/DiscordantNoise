extends Node

signal died


func on_death():
	died.emit()


func pause():
	get_tree().paused = true


func resume():
	get_tree().paused = false


func exit_game():
	get_tree().quit()
