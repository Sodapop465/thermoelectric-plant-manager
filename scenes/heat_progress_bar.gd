extends "res://scenes/progress_bar.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update UI based on GameState
	progress_bar.value = GameState.heat
