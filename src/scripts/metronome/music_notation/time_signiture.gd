# TimeSignature.gd
class_name TimeSignature extends Node

@export var top: int
@export var bottom: int

func _init(_top: int = 4, _bottom: int = 4) -> void:
	top = _top
	bottom = _bottom

func string() -> String:
	return "%d/%d" % [top, bottom]
