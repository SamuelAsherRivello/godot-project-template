## Fire bullet implementation
## Deals high damage with fire effect

# ========================================
# Class
# ========================================

class_name FireBullet
extends BaseBullet

# ========================================
# Constants
# ========================================

const FIRE_DAMAGE: float = 20.0

# ========================================
# Exports
# ========================================

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
# Methods (Godot)
# ========================================

# ========================================
# Methods (Custom)
# ========================================

## Override: Fire bullets deal more damage
func get_damage() -> float:
	return FIRE_DAMAGE

## Override: Fire bullet creates burn effect on impact
func on_impact(body: Node3D) -> void:
	super.on_impact(body)  # Call base implementation
	# TODO: Add fire particle effect or burn damage over time
	queue_free_animate()

## Override: Return fire effect type
func get_effect_type() -> String:
	return "fire"

# ========================================
# Event Handlers
# ========================================