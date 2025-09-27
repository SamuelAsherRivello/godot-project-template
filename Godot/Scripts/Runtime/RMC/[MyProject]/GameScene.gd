## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name GameScene
extends Node3D

# ========================================
# Constants
# ========================================

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var gameView: GameView
@export var gameController: GameController

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================
var gameModel: GameModel

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())

	# Validate
	CommonUtility.assert_node_not_null(gameController, "gameController")
	CommonUtility.assert_node_not_null(gameView, "gameView")

	gameModel = GameModel.new()
	gameController.gameModel = gameModel
	gameView.gameModel = gameModel
	pass

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================