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

static func find_child_of_type(parent: Node, type_to_find) -> Node:
	# Check if the parent itself is the type we're looking for
	if is_instance_of(parent, type_to_find):
		return parent

	# Recursively search through children
	for child in parent.get_children():
		var result := CommonUtility.find_child_of_type(child, type_to_find)
		if result != null:
			return result
	return null

# ========================================
# Event Handlers
# ========================================
