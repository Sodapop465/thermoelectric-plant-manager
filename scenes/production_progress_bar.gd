extends "res://scenes/progress_bar.gd"

func _ready():
	set_target_visibility(true)
	set_target_level(80)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update UI based on GameState
	progress_bar.value = GameState.elec_prod
	
	
