extends Node2D

@export var smoke_scene: PackedScene

const SMOKE_POS_OFFSET = Vector2(36, -40)

var smoke_timer := 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.get_state() == GameState.States.RUNNING:
		# Spawn smoke based on amount of water cooling
		var smoke_amount = (GameState.water_cooling + GameState.elec_prod) / 2
		# No smoke at 0
		if smoke_amount <= 0 or GameState.water_cooling <= 0:
			smoke_timer = 0.0
			return
		# Map smoke_amount [0,100] to spawn interval [2.0, 0.05]
		# Higher smoke_amount = more smoke = shorter interval
		var spawn_interval = lerp(2.0, 0.05, smoke_amount / 100.0)
		smoke_timer += delta
		while smoke_timer >= spawn_interval:
			smoke_timer -= spawn_interval
			_spawn_smoke(global_position + SMOKE_POS_OFFSET)

# Spawns a smoke at a given global position
func _spawn_smoke(position: Vector2):
	var smoke = smoke_scene.instantiate()
	smoke.global_position = position
	get_tree().current_scene.add_child(smoke)
