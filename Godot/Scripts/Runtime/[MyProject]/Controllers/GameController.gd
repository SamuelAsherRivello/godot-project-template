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
	var bullet := _packedScenes.packedScenes[0].instantiate() as Bullet
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = playerCharacter.global_position + Vector3(0, 0.75, 0)
	bullet.linear_velocity = Vector3(0, 5, -2)  # Up and slightly forward

	# Observe
	bullet.queue_free_completed.connect(_on_bullet_queue_free_completed)

	# Points
	_gameModel.score.Value += 1

func _on_bullet_queue_free_completed() -> void:

	# Points
	_gameModel.score.Value -= 1