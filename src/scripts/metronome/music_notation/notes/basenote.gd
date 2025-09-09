class_name BaseNote extends Node

var beat_value: float = 1.0  # subdivision length assuming whole note (quarters=4, eighths=8, etc.)

var _curr_connection : Signal

func _init():
	pass
	
	
func _ready():
	_connect_to_rhythm()
	Conductor.changed_time_sig.connect(_on_time_sig_changed)

func _connect_to_rhythm():
	var interval = _calc_interval()
	_curr_connection = Conductor.get_rhythm(interval)
	_curr_connection.connect(_on_beat)

func _on_time_sig_changed(new_sig):
	# clean up old connection
	if _curr_connection and _curr_connection.is_connected(_on_beat):
		_curr_connection.disconnect(_on_beat)
	# reconnect with new interval
	_connect_to_rhythm()

func _on_beat(count: int) -> void:
	# Default behavior: tell parent we triggered
	if get_parent().has_method("on_note_triggered"):
		get_parent().on_note_triggered(self, count)
	
# returns duration of the beat
func get_beat_duration() -> float:
	return Conductor.getNoteLength() * _calc_interval()

func _calc_interval() -> float:
	# Convert note’s beat_value into metronome subdivision
	# beat_value is denominator-style (quarter=4, eighth=8, etc.)
	# Conductor.time_sig.bottom tells us what "1 beat" is.
	#
	# Example: if beat_value=4 and time_sig.bottom=4 → 1 beat
	#          if beat_value=8 and time_sig.bottom=4 → 0.5 beat
	#          if beat_value=2 and time_sig.bottom=4 → 2 beats
	#
	return Conductor.getAttributes().time_signature.bottom / beat_value

func _exit_tree():
	if _curr_connection and _curr_connection.is_connected(_on_beat):
		_curr_connection.disconnect(_on_beat)
	Conductor.changed_time_sig.disconnect(_on_time_sig_changed)
