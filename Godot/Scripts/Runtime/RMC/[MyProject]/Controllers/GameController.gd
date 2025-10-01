## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

extends Node3D
class_name GameController

# ========================================
# Constants
# ========================================

const INPUT_VECTOR_DEFAULT := Vector2.ZERO

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var player: Node3D
@export var gameView: GameView

@export_group("Settings")
@export var move_speed_vector3: Vector3 = Vector3(5, 5, 5)
@export var rotate_speed_vector3: Vector3 = Vector3(0.0, 1.0, 0.0)

# ========================================
# Signals
# ========================================

signal example_signal(movement_vector: Vector3)

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

var _gameModel: GameModel
var _input_vector := INPUT_VECTOR_DEFAULT

# ========================================
# Methods (DI)
# ========================================

func _injected() -> void:

	# Validate
	CommonUtility.assert_refcounted_not_null(_gameModel, "_gameModel")
	pass

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())

	# Validate (only exported scene references here; injected deps validated in _injected)
	CommonUtility.assert_node_not_null(player, "player")
	CommonUtility.assert_node_not_null(gameView, "gameView")
	pass

func _process(delta: float) -> void:

	## print("%s._process(%s)" % [get_script().get_global_name(), str(delta)])
	process_input()
	process_movement(delta)
	process_rotation(delta)
	pass

func _exit_tree() -> void:

	print("%s._exit_tree()" % get_script().get_global_name())
	pass

# ========================================
# Methods (Custom)
# ========================================

func process_input() -> void:

	_input_vector = Vector2.ZERO

	# Get input direction
	if Input.is_action_pressed("ui_left"):
		_input_vector.x -= move_speed_vector3.x
	if Input.is_action_pressed("ui_right"):
		_input_vector.x += move_speed_vector3.x
	if Input.is_action_pressed("ui_up"):
		_input_vector.y -= move_speed_vector3.y
	if Input.is_action_pressed("ui_down"):
		_input_vector.y += move_speed_vector3.y
	pass

func process_movement(delta: float) -> void:

	if _input_vector.length() > 0:
		var movement_vector3 := Vector3(_input_vector.x, 0.0, _input_vector.y)
		player.position += movement_vector3 * delta
		example_signal.emit(movement_vector3)
		if _gameModel != null: # safety in case of timing
			_gameModel.score.Value += int(_input_vector.x)
			_gameModel.lives.Value += int(_input_vector.y)
	pass

func process_rotation(delta: float) -> void:

	player.rotate(rotate_speed_vector3, delta)
	pass

# ========================================
# Event Handlers
# ========================================

func _on_example_signal(parameter) -> void:

	print("%s._on_example_signal_received(%s)" % [get_script().get_global_name(), str(parameter)])
	pass