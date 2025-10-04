## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================
class_name PlayerCharacter
extends CharacterBody3D

# ========================================
# Constants
# ========================================

const GRAVITY: float = 9.8
const ROTATION_OFFSET: float = PI  # 180 degrees in radians

# ========================================
# Exports
# ========================================

@export_group("Resources")
@export var weapon_resource: WeaponResource

@export_group("Settings")
@export var acceleration: float = 1.0
@export var friction: float = 5.0
@export var rotation_speed: float = 15.0
@export var move_speed_vector3: Vector3 = Vector3(5, 5, 5)
@export var rotate_speed_vector3: Vector3 = Vector3(0.0, 1.0, 0.0)

# ========================================
# Signals
# ========================================

signal bullet_instantiate_requested;

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

var _input_vector : Vector2 = Vector2.ZERO
var _spawn_position: Vector3
var _gameModel: GameModel

# ========================================
# Methods (DI)
# ========================================

func _inject(gameModel: GameModel) -> void:

	print("%s._injected()" % get_script().get_global_name())

	# Store
	_gameModel = gameModel

	# Validate
	CommonUtility.assert_node_not_null(_gameModel, "_gameModel")
	pass

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:
	_spawn_position = global_position  # Cache spawn position
	pass

func _process(_delta: float) -> void:
	process_input()
	pass

func _physics_process(delta: float) -> void:
	process_movement(delta)
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
	if Input.is_action_pressed("ui_accept"):
		bullet_instantiate_requested.emit()
		pass

func process_movement(delta: float) -> void:
	var target_velocity: Vector3 = Vector3(_input_vector.x, velocity.y, _input_vector.y) * move_speed_vector3

	# Check for death by falling
	if global_position.y < GameConstants.WORLD_BOTTOM_Y:
		die()

	# Apply gravity as acceleration
	if not is_on_floor():
		velocity.y -= GRAVITY * delta  # Proper acceleration formula: Δv = a * Δt

	# Apply horizontal movement with acceleration/friction
	if _input_vector.length() > 0:
		velocity.x = lerp(velocity.x, target_velocity.x, acceleration * delta)
		velocity.z = lerp(velocity.z, target_velocity.z, acceleration * delta)

		# Calculate target rotation based on movement direction
		var movement_direction: Vector3 = Vector3(velocity.x, 0, velocity.z).normalized()
		if movement_direction.length() > 0.1:  # Only rotate if we're moving significantly
			var target_position: Vector3 = global_position + movement_direction
			var current_rotation: Vector3 = global_transform.basis.get_euler()

			# Create a temporary transform for the target rotation and apply the offset
			var target_transform: Transform3D = global_transform.looking_at(target_position)
			var target_rotation: Vector3 = target_transform.basis.get_euler()
			target_rotation.y += ROTATION_OFFSET  # Add 180 degrees offset

			# Lerp between current and target rotation
			var new_rotation: Vector3 = Vector3(
				current_rotation.x,
				lerp_angle(current_rotation.y, target_rotation.y, delta * rotation_speed),
				current_rotation.z
			)
			global_transform.basis = Basis.from_euler(new_rotation)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)


	move_and_slide()
	pass

func die() -> void:
	_gameModel.lives.Value -= 1
	respawn()

func respawn() -> void:
	# Reset position and velocity
	global_position = _spawn_position
	velocity = Vector3.ZERO
	pass

# ========================================
# Event Handlers
# ========================================