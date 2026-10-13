extends Node

# Math variables
const DELTA_PRODUCTION = 8	# Change in production
const UNMET_DEMAND_LEEWAY = 2 # Game hours
var DEFAULT_AIR_COOLING_FACTOR = 0.01
var DEFAULT_WATER_COOLING_FACTOR = 0.03
var DEFAULT_ELEC_PROD_HEAT_FACTOR = 0.05

# Global Game State
enum States {
	START,
	RUNNING,
	LOSE_HEAT,
	LOSE_DEMAND,
	WIN
}
var _current_state = States.START
signal state_changed(value)

# Game time in 24:00
var time_minutes = 0
var time_hour = 0
var day = 0

# User sliders
var gen_effort = 0
var air_cooling = 0
var water_cooling = 0
var air_cooling_factor = 0
var water_cooling_factor = 0

# Plant Production
var elec_prod = 0
var heat = 0
var elec_prod_heat_factor = 0

# Plant Demand
var demand = 0
var time_last_met_demand = time_hour + (time_minutes / 60.0)

# Changing the global state and sending a signal
func change_state(state: States):
	print("Changing global state to: ", States.find_key(_current_state))
	_current_state = state
	state_changed.emit(state)
	
	# Reset game when changing to running state
	if state == States.RUNNING:
		_reset_game()
	
	# Change to end scene
	if state == States.LOSE_HEAT or state == States.LOSE_DEMAND:
		get_tree().change_scene_to_file("res://scenes/lose.tscn")

func get_state() -> States:
	return _current_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Run the main game
	if get_state() == States.RUNNING:
		_update_time(delta)
		_update_demand()
		_update_electricity_production(delta)
		_update_heat(delta)

func _reset_game() -> void:
	air_cooling_factor = DEFAULT_AIR_COOLING_FACTOR
	water_cooling_factor = DEFAULT_WATER_COOLING_FACTOR
	elec_prod_heat_factor = DEFAULT_ELEC_PROD_HEAT_FACTOR

	# Game time in 24:00
	time_minutes = 0
	time_hour = 0
	day = 0

	# User sliders
	gen_effort = 0
	air_cooling = 0
	water_cooling = 0

	# Plant Production
	elec_prod = 0
	heat = 0

	# Plant Demand
	demand = 0
	time_last_met_demand = time_hour + (time_minutes / 60.0)
	

# Update the time Make one day ~150 seconds (3 min)
func _update_time(delta: float) -> void:
	time_minutes += delta * (1440 / 150)
	# Handle hour rollover
	while time_minutes >= 60:
		time_minutes -= 60
		time_hour += 1
	# Handle day rollover
	if time_hour >= 24:
		time_hour = 0
		day += 1
	# If player survives for 2 days, they win
	if day == 2:
		change_state(States.WIN)


# Simulates electricity demand based on time of day
func _update_demand() -> void:
	var current_time = time_hour + (time_minutes / 60.0)
	if current_time < 5:
		demand = 25
	elif current_time < 8:
		# Morning ramp-up
		demand = lerpf(25, 75, (current_time - 5) / 3.0)
	elif current_time < 10:
		# Morning peak
		demand = lerpf(75, 60, (current_time - 8) / 2.0)
	elif current_time < 16:
		# Daytime usage
		demand = 60
	elif current_time < 19:
		# Evening peak
		demand = lerpf(60, 90, (current_time - 16) / 3.0)
	elif current_time < 21:
		demand = 90
	else:
		# Night decline
		demand = lerpf(90, 25, (current_time - 21) / 3.0)
	
	# Check if player if meeting demand
	if elec_prod >= demand:
		time_last_met_demand = current_time
	elif (current_time - time_last_met_demand) > UNMET_DEMAND_LEEWAY: 
		change_state(States.LOSE_DEMAND)
	

# Update electricity production based on generation effort
func _update_electricity_production(delta: float) -> void:
	if elec_prod < gen_effort:
		elec_prod += delta * DELTA_PRODUCTION
	elif elec_prod > gen_effort:
		elec_prod -= delta * DELTA_PRODUCTION

# Calculate heat based on electricity production
func _update_heat(delta: float) -> void:
	heat += elec_prod * elec_prod_heat_factor
	heat -= air_cooling * air_cooling_factor
	heat -= water_cooling * water_cooling_factor
	if heat < 0:
		heat = 0
		
	# Check if heat is above 100
	if heat > 100:
		change_state(States.LOSE_HEAT)
