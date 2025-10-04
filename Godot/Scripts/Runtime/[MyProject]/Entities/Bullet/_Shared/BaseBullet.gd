## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name BaseBullet
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

var _is_animating_death: bool = false

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if _is_animating_death:
		return

	if position.y < GameConstants.WORLD_BOTTOM_Y:
		queue_free_completed.emit()
		queue_free()

# ========================================
# Methods (Custom)
# ========================================

func queue_free_animate() -> void:
	if _is_animating_death:
		return

	_is_animating_death = true

	# Create a tween to shrink the bullet to 0 size over 0.1 seconds
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector3.ZERO, 0.1)
	tween.tween_callback(queue_free)

# ========================================
# Event Handlers
# ========================================