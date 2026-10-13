extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	# Increase air cooling ability
	GameState.air_cooling_factor = GameState.air_cooling_factor * 2
	GameState.air_cooling_units += 1
	GameState.change_state(GameState.States.RUNNING)
