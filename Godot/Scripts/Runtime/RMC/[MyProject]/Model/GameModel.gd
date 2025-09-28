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

# ========================================
# Properties
# ========================================

var instructions = ReactiveProperty.new("Use WASD")
var level = ReactiveProperty.new(1)
var lives = ReactiveProperty.new(0)
var score = ReactiveProperty.new(0)

# ========================================
# Variables
# ========================================

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
