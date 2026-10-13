extends Node2D

@export var rise_speed: float = 30.0
@export var fade_in_time: float = 0.2
@export var fade_out_time: float = 2.0

var elapsed := 0.0
var total_time := 0.0

func _ready() -> void:
	total_time = fade_in_time + fade_out_time

	# Start fully transparent
	modulate.a = 0.0


func _process(delta: float) -> void:
	elapsed += delta

	# Move upward
	position.y -= rise_speed * delta

	# Fade in quickly
	if elapsed < fade_in_time:
		modulate.a = elapsed / fade_in_time

	# Fade out slowly
	else:
		var fade_elapsed = elapsed - fade_in_time
		modulate.a = 1.0 - (fade_elapsed / fade_out_time)

	# Remove when finished
	if elapsed >= total_time:
		queue_free()
