## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name GameModel
extends RefCounted

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

# ========================================
# Signals
# ========================================

signal on_model_changed()

# ========================================
# Properties
# ========================================

var instructions: String:
	get:
		return _instructions
	set(value):
		_instructions = value
		on_model_changed.emit()

var level: int:
	get:
		return _level
	set(value):
		_level = value
		on_model_changed.emit()

var lives: int:
	get:
		return _lives
	set(value):
		_lives = value
		on_model_changed.emit()

var score: int:
	get:
		return _score
	set(value):
		_score = value
		on_model_changed.emit()

# ========================================
# Variables
# ========================================

var _instructions: String = "Use WASD"
var _level: int = 1
var _lives: int = 0
var _score: int = 0

# ========================================
# Methods (Godot)
# ========================================

# Constructor
func _init() -> void:
	print("%s._init()" % get_script().get_global_name())

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================