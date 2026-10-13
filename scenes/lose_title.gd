extends Label

@export_multiline var lose_heat_text: String
@export_multiline() var lose_demand_text: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.get_state() == GameState.States.LOSE_HEAT:
		self.text = lose_heat_text
	elif GameState.get_state() == GameState.States.LOSE_DEMAND:
		self.text = lose_demand_text
