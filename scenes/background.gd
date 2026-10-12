extends ColorRect

@export var day_color: Color
@export var night_color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = GameState.time_hour + GameState.time_minutes / 60.0
	var blend = 0.0

	# Sunset: 18:00 -> 20:00
	if time >= 18.0 and time < 20.0:
		blend = inverse_lerp(18.0, 20.0, time)

	# Night: 20:00 -> 04:00
	elif time >= 20.0 or time < 4.0:
		blend = 1.0

	# Sunrise: 04:00 -> 06:00
	elif time >= 4.0 and time < 6.0:
		blend = 1.0 - inverse_lerp(4.0, 6.0, time)

	# Day: 06:00 -> 18:00
	else:
		blend = 0.0

	color = day_color.lerp(night_color, blend)
