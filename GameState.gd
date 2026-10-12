extends Node

# Game time in 24:00
var time_minutes = 0
var time_hour = 0
var day = 0

# User sliders
var gen_effort = 0
var air_cooling = 0
var water_cooling = 0

# Plant Status
var elec_prod = 0
var heat = 0
var delta_production = 5	# Change in production


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update the time Make one day ~150 seconds (3 min)
	time_minutes += delta * (1440 / 150)
	# Handle hour rollover
	while time_minutes >= 60:
		time_minutes -= 60
		time_hour += 1
	# Handle day rollover
	if time_hour >= 24:
		time_hour = 0
		day += 1

	# Modulate electricity production based on generation effort
	if elec_prod < gen_effort:
		elec_prod += delta * delta_production
	elif elec_prod > gen_effort:
		elec_prod -= delta * delta_production
