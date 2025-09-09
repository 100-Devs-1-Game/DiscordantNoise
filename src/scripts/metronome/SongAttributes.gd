class_name SongAttributes extends Node

@export var bpm : float = 120
@onready var time_signature : TimeSignature = $TimeSignature


func apply_preset(preset: SongAttributesResource) -> void:
	bpm = preset.bpm
	time_signature.top = preset.time_signature_top
	time_signature.bottom = preset.time_signature_bottom
