## Template for class
## Provides structure, standards, conventions

# ========================================
# Class
# ========================================

@tool
class_name RandomizeLevelTool
extends EditorPlugin

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
# Methods (DI)
# ========================================

# ========================================
# Methods (Godot)
# ========================================

func _enter_tree():
	print("RandomizeLevelTool: _enter_tree called, registering tool menu item.")
	add_tool_menu_item("Randomize Obstacle", self._randomize_obstacle)

func _exit_tree():
	print("RandomizeLevelTool: _exit_tree called, removing tool menu item.")
	remove_tool_menu_item("Randomize Obstacle & Save Level")


# ========================================
# Methods (Custom)
# ========================================

func _randomize_obstacle() -> void:
	var root: Node = get_editor_interface().get_edited_scene_root()
	if root == null:
		push_warning("Cannot run tool: No scene is open.")
		return

	var base_scene := CommonUtility.find_child_of_type(root, BaseScreen)
	if base_scene == null:
		push_warning("Cannot run tool: Could not find BaseScreen node.")
		return

	var base_level := CommonUtility.find_child_of_type(base_scene, BaseLevel)
	if base_level == null:
		push_warning("Cannot run tool: Could not find BaseLevel node.")
		return

	var obstacle := CommonUtility.find_child_of_type(base_level, Obstacle)
	if obstacle == null:
		push_warning("Cannot run tool: Could not find Obstacle node.")
		return

	# Use only x/z values of 4 and -4 (no 0)
	var positions: Array = [
		Vector3(4, 0, 4),
		Vector3(4, 0, -4),
		Vector3(-4, 0, 4),
		Vector3(-4, 0, -4),
	]

	obstacle.position = positions[randi() % positions.size()]
	print("Obstacle moved to %s" % obstacle.position)

	var scene_path: String = root.scene_file_path
	var packed_scene := PackedScene.new()
	var result := packed_scene.pack(root)
	if result != OK:
		push_error("Failed to pack scene: %s" % scene_path)
		return

	var err: int = ResourceSaver.save(packed_scene, scene_path)
	if err != OK:
		push_error("Failed to save scene: %s" % scene_path)
	else:
		print("Scene saved: %s" % scene_path)




# ========================================
# Event Handlers
# ========================================