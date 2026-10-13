extends Button

@export var upgrade_factor: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_button_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	# Increase production responsiveness
	var increase_amt = GameState.delta_production * upgrade_factor
	GameState.delta_production = increase_amt
	GameState.change_state(GameState.States.RUNNING)
