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

# ========================================
# Exports
# ========================================

@export_group("Scenes")
@export var bullet: PackedScene

@export_group("Nodes")
@export var playerCharacter: PlayerCharacter
@export var gameView: GameView


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

# ========================================
# Methods (DI)
# ========================================

func _injected() -> void:

	print("%s._injected()" % get_script().get_global_name())

	# Validate
	CommonUtility.assert_refcounted_not_null(_gameModel, "_gameModel")
	pass

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())

	# Validate
	CommonUtility.assert_node_not_null(playerCharacter, "player")
	CommonUtility.assert_node_not_null(gameView, "gameView")

	# Observe
	playerCharacter.bullet_instantiate_requested.connect(_on_bullet_instantiate_requested)
	pass


# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================

func _on_bullet_instantiate_requested() -> void:

	# Instantiate
	var bullet_instance := bullet.instantiate() as Bullet
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = playerCharacter.global_position + Vector3(0, 1, 0)
	bullet_instance.linear_velocity = Vector3(0, 5, -2)  # Up and slightly forward

	# Observe
	bullet_instance.queue_free_completed.connect(_on_bullet_queue_free_completed)

	# Points
	_gameModel.score.Value += 1

func _on_bullet_queue_free_completed() -> void:

	# Points
	_gameModel.score.Value -= 1