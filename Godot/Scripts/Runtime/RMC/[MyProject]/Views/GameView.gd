## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================
class_name GameView
extends CanvasLayer

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var corner_ui_upper_left: CornerUI
@export var corner_ui_upper_right: CornerUI
@export var corner_ui_lower_left: CornerUI
@export var corner_ui_lower_right: CornerUI

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

var gameModel: GameModel:
	get:
		return _gameModel
	set(value):
		_gameModel = value
		_gameModel.on_model_changed.connect(_on_model_changed)
		_on_model_changed()


# ========================================
# Variables
# ========================================
var _gameModel: GameModel

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())
	pass

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================

func _on_model_changed () -> void:

	corner_ui_upper_left.richTextLabel.text = "Lives: %03d" % gameModel.lives
	corner_ui_upper_right.richTextLabel.text = "Score: %03d" % gameModel.score
	corner_ui_lower_left.richTextLabel.text = "Tip: %s" % gameModel.instructions
	corner_ui_lower_right.richTextLabel.text = "Level: %03d" % gameModel.level
