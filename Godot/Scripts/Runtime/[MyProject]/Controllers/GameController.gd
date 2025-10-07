## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name GameController
extends Node3D

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var _playerCharacter: PlayerCharacter
@export var _gameView: GameView

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

var _gameModel: GameModel
var _packedScenes: PackedScenes

# ========================================
# Methods (DI)
# ========================================

func _inject(gameModel: GameModel, packedScenes: PackedScenes) -> void:

	print("%s._injected()" % get_script().get_global_name())

	# Store
	_gameModel = gameModel
	_packedScenes = packedScenes

	# Validate
	CommonUtility.assert_node_not_null(_gameModel, "_gameModel")
	pass

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())

	# Validate
	CommonUtility.assert_node_not_null(_playerCharacter, "player")
	CommonUtility.assert_node_not_null(_gameView, "gameView")

	# Observe
	_playerCharacter.shoot_bullet_requested.connect(_on_player_shoot_bullet_requested)
	_playerCharacter.died.connect(_on_player_death_requested)


# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================

func _on_player_shoot_bullet_requested() -> void:

	var active_weapon := _playerCharacter.get_active_weapon()
	if active_weapon.can_shoot():

		# Instantiate
		var bullet : IBullet = active_weapon.bullet_packed_scene.instantiate() as IBullet
		bullet.add_to_group(GameConstants.GROUP_BULLETS)
		get_tree().current_scene.add_child(bullet)

		# Get player's forward direction (accounting for the 180-degree rotation offset)
		var player_forward: Vector3 = _playerCharacter.global_transform.basis.z

		# Spawn bullet in front of player's face, offset by player's movement direction
		var spawn_offset: float = .8  # Distance in front of player
		var face_height: float = 0.4  # Height of face
		var velocity_offset: Vector3 = _playerCharacter.velocity * 0.1  # Small offset based on player velocity
		bullet.global_position = _playerCharacter.global_position + Vector3(0, face_height, 0) + player_forward * spawn_offset + velocity_offset

		# Give bullet velocity from weapon resource only
		var bullet_base_velocity: Vector3 = player_forward * active_weapon.bullet_velocity.x + Vector3.UP * active_weapon.bullet_velocity.y
		bullet.linear_velocity = bullet_base_velocity

		# Observe
		bullet.queue_free_completed.connect(_on_bullet_queue_free_completed)

		# Points
		_gameModel.score.Value += 1

func _on_bullet_queue_free_completed() -> void:

	# Points
	_gameModel.score.Value -= 1

func _on_player_death_requested() -> void:

	get_tree().call_group(GameConstants.GROUP_BULLETS, "queue_free_animate")

	_gameModel.lives.Value -= 1

	_playerCharacter.respawn()
