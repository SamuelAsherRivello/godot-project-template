## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name TemplateClass
extends Node3D

# ========================================
# Constants
# ========================================

const INPUT_VECTOR_DEFAULT := Vector2.ZERO

# ========================================
# Exports
# ========================================

@export_group("Nodes")
@export var target_node_3D: Node3D

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

var instructions: String:
	get:
		return _instructions
	set(value):
		_instructions = value
		example_signal.emit()

# ========================================
# Variables
# ========================================

var _instructions: String = ""

# ========================================
# Methods (Godot)
# ========================================

func _ready() -> void:

	print("%s._ready()" % get_script().get_global_name())
	pass

func _process(delta: float) -> void:

	print("%s._process(%s)" % [get_script().get_global_name(), str(delta)])
	pass

func _exit_tree() -> void:

	print("%s._exit_tree()" % get_script().get_global_name())
	pass

# ========================================
# Methods (Custom)
# ========================================

# ========================================
# Event Handlers
# ========================================

func _on_example_signal(parameter) -> void:

	print("%s._on_example_signal_received(%s)" % [get_script().get_global_name(), str(parameter)])
	pass