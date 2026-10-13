extends Label

@export var color_flash_1: Color
@export var color_flash_2: Color

var flash_timer := 0.0
var using_first_color := true

func _ready() -> void:
	modulate = color_flash_1

func _process(delta: float) -> void:
	# Flash the warning when production < demand
	if GameState.elec_prod < GameState.demand:
		self.visible = true
		flash_timer += delta

		if flash_timer >= 0.5:
			flash_timer = 0.0
			using_first_color = !using_first_color

			modulate = color_flash_1 if using_first_color else color_flash_2
	else:
		self.visible = false
