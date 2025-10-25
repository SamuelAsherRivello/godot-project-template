## Eye blink animation controller
## Simulates natural human eye blinking behavior

# ========================================
# Class
# ========================================

class_name EyeBlinkAnimationPlayer
extends AnimationPlayer

# ========================================
# Constants
# ========================================

const MIN_BLINK_INTERVAL: float = 2.0
const MAX_BLINK_INTERVAL: float = 8.0
const BLINK_PROBABILITY: float = 0.9

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

var _blink_timer: Timer

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:
	_setup_blink_timer()
	_schedule_next_blink()
	pass

# ========================================
# Methods (Custom)
# ========================================

func _setup_blink_timer() -> void:
	_blink_timer = Timer.new()
	_blink_timer.one_shot = true
	_blink_timer.timeout.connect(_on_blink_timer_timeout)
	add_child(_blink_timer)

func _schedule_next_blink() -> void:
	var wait_time: float = randf_range(MIN_BLINK_INTERVAL, MAX_BLINK_INTERVAL)
	_blink_timer.start(wait_time)

func _try_blink() -> void:
	# Random chance to actually blink
	if randf() < BLINK_PROBABILITY:
		self.play("EyeBlinkAnimation")

	# Schedule the next potential blink
	_schedule_next_blink()

# ========================================
# Event Handlers
# ========================================

func _on_blink_timer_timeout() -> void:
	_try_blink()
