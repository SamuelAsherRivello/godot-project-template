## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name PlayerShip
extends CharacterBody3D

# ========================================
# Constants
# ========================================

const GRAVITY: float = 9.8
const ROTATION_OFFSET: float = PI  # 180 degrees in radians

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var navigationAgent3D: NavigationAgent3D

# ========================================
# Signals
# ========================================

# ========================================
# Properties
# ========================================

# ========================================
# Variables
# ========================================

var _input_vector : Vector2 = Vector2.ZERO

# ========================================
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	process_input()
	pass

func _physics_process(delta: float) -> void:
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
	if Input.is_action_pressed("ui_accept"):
		navigate_to_point()
		pass

func navigate_to_point () -> void:
	print("ok")

	navigationAgent3D.get_current_navigation_path()
	pass;

# ========================================
# Event Handlers
# ========================================