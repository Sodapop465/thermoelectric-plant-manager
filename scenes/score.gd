extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Based on 60 million gallons used per day estimate
	self.text = "Score: %d" % ((36000 - GameState.water_used))
