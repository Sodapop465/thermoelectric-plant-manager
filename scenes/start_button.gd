extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	# Change game state
	GameState.change_state(GameState.States.RUNNING)
	get_tree().change_scene_to_file("res://scenes/game.tscn")
