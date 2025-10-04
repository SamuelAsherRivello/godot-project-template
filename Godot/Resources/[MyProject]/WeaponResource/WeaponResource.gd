## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name WeaponResource
extends Resource

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

@export var cooldown : float = 0.2
@export var damage : float = 10
@export var bullet_packed_scene: PackedScene

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

var _last_shot_time: float = -INF

# ========================================
# Methods (Godot)
# ========================================

func _init() -> void:

	print("%s._ready()" % get_script().get_global_name())
	pass

# ========================================
# Methods (Custom)
# ========================================

func can_shoot() -> bool:
	var now: float = Time.get_ticks_msec() / 1000.0
	if now - _last_shot_time >= cooldown:
		_last_shot_time = now
		return true
	return false

# ========================================
# Event Handlers
# ========================================