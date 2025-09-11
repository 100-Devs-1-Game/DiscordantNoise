class_name Metronome extends Node

@onready var attributes : SongAttributes = $SongAttributes
@onready var notifier : RhythmNotifier = $RhythmNotifier

signal beat_occured
signal changed_time_sig


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activateNotifier()
	pass

#emit different beat signals for each note denomination
	
func getAttributes() -> SongAttributes:
	return attributes
	
#set SongAttribtues i.e, bpm and timesig based on a resource
func setAttributes(att : SongAttributesResource) -> void:
	if (att == null):
		att = load("res://assets/resources/SongAttributes/default.tres")
	attributes.apply_preset(att)
	emit_signal("changed_time_sig")
	pass
	
#set SongAttributes based on a name
func setAttributesName(att_name : String) -> void:
	var att = load(str("res://assets/resources/SongAttributes/", att_name, ".tres"))
	setAttributes(att)
	pass
	
func activateNotifier() -> void:
	notifier.bpm = attributes.bpm

	#var b = notifier.beats(1)
	#b.connect(func(count): print("Hello from note %d!" % (count)))
	var a = notifier.beats(1)
	a.connect(func(count): 
		emit_signal("beat_occured")
		print("Hello from note %d!" % (count))
		)
	notifier.beats(attributes.time_signature.top).connect(func(count): print("Hello from measure %d!" % (count)))
	notifier.running = true
	
	pass
	
func getNoteLength() -> float:
	return notifier.beat_length
	
func get_rhythm(interval: float, offset: float = 0.0, once: bool = false) -> Signal:
	return notifier.beats(interval, !once, offset)
	
