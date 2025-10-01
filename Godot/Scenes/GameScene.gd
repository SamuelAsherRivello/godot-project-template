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

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())

	# Validate
	CommonUtility.assert_node_not_null(gameController, "gameController")
	CommonUtility.assert_node_not_null(gameView, "gameView")

	# Initialize Dependency Injection
	_bootstrap_di()
	pass

# ========================================
# Methods (Custom)
# ========================================

func _bootstrap_di() -> void:

	# Bind GameModel as a shared singleton and expose via variable name '_gameModel'
	DI.bind(GameModel, DI.As.SINGLETON).to_var("_gameModel")

	# Provide dependency graph for this subtree (injects children: controller, view, etc.)
	DI.provide_tree(self)
	pass

# ========================================
# Event Handlers
# ========================================