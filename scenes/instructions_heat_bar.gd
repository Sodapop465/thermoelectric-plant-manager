extends "res://scenes/progress_bar.gd"

func _ready():
	super._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update UI based on GameState
	progress_bar.value = 90
