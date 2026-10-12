extends Node2D

@export var target_bar_level = 0
@export var target_bar_visiblity = true
@export var target_bar_color: Color
@export var bar_background_color: Color
@export var bar_progress_color: Color

@onready var target_bar: ColorRect = $TextureProgressBar/ColorRect
@onready var progress_bar: TextureProgressBar = $TextureProgressBar

func _ready():
	# Apply progress bar colors
	var progress_gradient := (progress_bar.texture_progress as GradientTexture2D).duplicate()
	progress_gradient.gradient = progress_gradient.gradient.duplicate()
	var under_gradient := (progress_bar.texture_under as GradientTexture2D).duplicate()
	under_gradient.gradient = under_gradient.gradient.duplicate()

	# Reassign the unique resources
	progress_bar.texture_progress = progress_gradient
	progress_bar.texture_under = under_gradient

	# Apply colors
	progress_gradient.gradient.set_color(0, bar_progress_color)
	under_gradient.gradient.set_color(0, bar_background_color)
	
	# Set target bar properties
	target_bar.color = target_bar_color
	target_bar.visible = target_bar_visiblity
	set_target_level(target_bar_level)
	

# Sets the target bar level
# Range: 0-100
func set_target_level(level: int) -> void:
	if level < 0:
		level = 0
	if level > 100:
		level = 100
	target_bar_level = level
	var percent := float(target_bar_level) / 100.0
	var x_pos := progress_bar.size.x * percent

	target_bar.position.x = x_pos
	
# Sets the target bar visibility
func set_target_visibility(visibility: bool) -> void:
	target_bar.visible = target_bar_visiblity
	
# Sets progress bar visibility
func set_progress_color(color: Color) -> void:
	var progress_gradient = progress_bar.texture_progress as GradientTexture2D
	progress_gradient.gradient.set_color(0, color)
