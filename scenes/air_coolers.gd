extends Node2D

var sprites: Array[Sprite2D] = []

const SPACING = 34.0
const TEXTURE = preload("res://textures/air_cooler.png")

func _process(_delta: float) -> void:
	var target_sprite_count = GameState.air_cooling_units

	# Add missing sprites
	while sprites.size() < target_sprite_count:
		var pos = Vector2(-(sprites.size() * SPACING), 0)
		spawn_sprite(pos)

	# Remove excess sprites
	while sprites.size() > target_sprite_count:
		var sprite = sprites.pop_back()
		sprite.queue_free()


func spawn_sprite(pos: Vector2) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = TEXTURE
	sprite.position = pos

	add_child(sprite)
	sprites.append(sprite)
