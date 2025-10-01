## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

class_name CommonUtility
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

# ========================================
# Methods (Godot)
# ========================================

# ========================================
# Methods (Custom)
# ========================================

static func assert_refcounted_not_null(node: RefCounted, node_name : String) -> void:

	if (node == null):
		var error_message := "CommonUtility.assert_refcounted_not_null (%s) - Must Not Be Null " % node_name
		print(error_message)
		assert(false, error_message)
	pass

static func assert_node_not_null(node: Node, node_name : String) -> void:

	if (node == null):
		var error_message := "CommonUtility.assert_node_not_null (%s) - Must Not Be Null " % node_name
		print(error_message)
		assert(false, error_message)
	pass

# ========================================
# Event Handlers
# ========================================