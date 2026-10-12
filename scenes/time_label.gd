extends Label

var last_hour := -1
var last_minute := -1


func _process(delta: float) -> void:
	# Change time based on GameState
	if GameState.time_hour != last_hour or GameState.time_minutes != last_minute:
		last_hour = GameState.time_hour
		last_minute = GameState.time_minutes

		text = "%02d:%02d" % [last_hour, last_minute]
