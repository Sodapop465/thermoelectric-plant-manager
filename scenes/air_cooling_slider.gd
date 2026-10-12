extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value_changed.connect(_on_slider_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Update GameState
func _on_slider_changed(value: float) -> void:
	GameState.air_cooling = value
