## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name AudioManager
extends Node

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

# ========================================
# Variables
# ========================================

static var _instance: AudioManager = null
var _sounds_played_this_frame: Dictionary = {}  # Track sounds played per frame

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:
	_instance = self
	print("%s._ready()" % get_script().get_global_name())

func _process(_delta: float) -> void:
	# Clear the frame counter each frame
	_sounds_played_this_frame.clear()

# ========================================
# Methods (Custom)
# ========================================

# Play audio by full resource path (static method)
static func play_audio(audio_path: String, max_per_frame: int = 1) -> void:
	if _instance:
		_instance._play_audio_internal(audio_path, max_per_frame)
	else:
		push_error("AudioManager instance not found. Make sure it's registered as an autoload.")

# Internal non-static method that does the actual work
func _play_audio_internal(audio_path: String, max_per_frame: int) -> void:
	# Check if we should limit the number of this sound per frame
	if max_per_frame > 0:
		var count: int = _sounds_played_this_frame.get(audio_path, 0)
		if count >= max_per_frame:
			return  # Already played max times this frame
		_sounds_played_this_frame[audio_path] = count + 1

	var stream := load(audio_path) as AudioStream
	if not stream:
		push_error("Audio not found or invalid: %s" % audio_path)
		return

	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.autoplay = false
	player.bus = "Master"
	player.finished.connect(player.queue_free)

	add_child(player)
	player.play()
