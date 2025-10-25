## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name StartMenuView
extends CanvasLayer

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var play_game_button: Button

@export_group("Settings")
@export var scene_to_load: PackedScene

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	play_game_button.pressed.connect(_on_play_game_button_pressed)
	pass

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================

func _on_play_game_button_pressed() -> void:
	print("%s._on_play_game_button_pressed()" % get_script().get_global_name())
	# Load and change to the exported scene
	if scene_to_load:
		get_tree().change_scene_to_packed(scene_to_load)
	else:
		push_error("No scene assigned to 'scene_to_load' export variable.")
