## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================
class_name Bullet
extends RigidBody3D

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

# ========================================
# Signals
# ========================================

signal queue_free_completed()

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
# Methods (Godot)
# ========================================

func _ready() -> void:

	# print("%s._ready()" % get_script().get_global_name())
	pass

func _process(_delta: float) -> void:
	if position.y < GameConstants.WORLD_BOTTOM_Y:
		# print("%s position (y: %.2f). So destroying" % [get_script().get_global_name(), position.y])
		queue_free_completed.emit()
		queue_free()

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================