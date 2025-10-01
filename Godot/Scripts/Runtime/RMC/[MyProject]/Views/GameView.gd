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

var _gameModel: GameModel

# ========================================
# Variables
# ========================================

# ========================================
# Methods (DI)
# ========================================

func _injected() -> void:

	# Validate
	CommonUtility.assert_refcounted_not_null(_gameModel, "_gameModel")

	# Observe
	_gameModel.level.subscribe(_on_model_changed).dispose_with(self)
	_gameModel.lives.subscribe(_on_model_changed).dispose_with(self)
	_gameModel.instructions.subscribe(_on_model_changed).dispose_with(self)
	_gameModel.score.subscribe(_on_model_changed).dispose_with(self)
	pass

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

func _on_model_changed(_new_value) -> void:
	corner_ui_upper_left.richTextLabel.text = "Lives: %03d" % _gameModel.lives.Value
	corner_ui_upper_right.richTextLabel.text = "Score: %03d" % _gameModel.score.Value
	corner_ui_lower_left.richTextLabel.text = "Tip: %s" % _gameModel.instructions.Value
	corner_ui_lower_right.richTextLabel.text = "Level: %03d" % _gameModel.level.Value