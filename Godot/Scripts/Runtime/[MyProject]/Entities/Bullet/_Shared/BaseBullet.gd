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

var _has_started_queue_free_animate: bool = false
var _has_started_body_entered: bool = false

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	# Enable contact monitoring for collisions
	contact_monitor = true
	max_contacts_reported = 1

	# Play bullet sound
	AudioManager.play_audio(GameConstants.AUDIO_POP01)

	# Connect to collision signal
	body_entered.connect(_on_body_entered)

	pass

func _process(_delta: float) -> void:
	if _has_started_queue_free_animate:
		return

	if position.y < GameConstants.WORLD_BOTTOM_Y:
		queue_free_completed.emit()
		queue_free()

# ========================================
# Methods (Custom)
# ========================================

func queue_free_animate() -> void:

	if _has_started_queue_free_animate:
		return

	_has_started_queue_free_animate = true

	# Play bullet sound
	AudioManager.play_audio(GameConstants.AUDIO_COLLIDE01)

	# Create a tween to shrink the bullet to 0 size over 0.1 seconds
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector3.ZERO, 0.1)
	tween.tween_callback(queue_free)

# ========================================
# Event Handlers
# ========================================

func _on_body_entered(body: Node) -> void:

	if _has_started_body_entered:
			return

	_has_started_body_entered = true

	print("Bullet collided with: %s" % body.name)

	# Play collision sound
	AudioManager.play_audio(GameConstants.AUDIO_COLLIDE01)

	# Optionally queue free the bullet after collision
	# queue_free_animate()