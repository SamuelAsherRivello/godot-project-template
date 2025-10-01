## This class serves as the registrar for
## all dependencies that can be injected via the [DependencyProvider] whether
## set [u]before[/u] or [u]during[/u] runtime.
@tool
class_name DependencyRegistrar
extends Node


@export_category("Required")
@export var _dependencies: Array[Node]:
	get:
		return _dependencies
	set(value):
		_dependencies = value
		
		if Engine.is_editor_hint():
			update_configuration_warnings()

var _dependencies_dict: Dictionary[StringName, Node]


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	for dependency: Node in _dependencies:
		if dependency == null:
			warnings.append("There cannot be an unassigned Dependency node.")
			break
	
	return warnings


func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		_initialize_dependencies()

func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		_deinitialize_dependencies()


func _initialize_dependencies() -> void:
	register_dependency(self)
	
	for dependency: Node in _dependencies:
		register_dependency(dependency)
	_dependencies.clear()

func _deinitialize_dependencies() -> void:
	_dependencies_dict.clear()


## Gets a node dependency via its name as [StringName] and returns it or [code]null[/code].
func get_dependency(dependency_name: StringName) -> Node:
	return _dependencies_dict.get(dependency_name)


## Registers a node dependency to the registrar.
func register_dependency(dependency: Node) -> void:
	if dependency == null:
		push_warning("The 'dependency' being registered cannot be null.")
		return
		
	var dependency_name: StringName = DependencyInjectionHelper \
		.get_resolved_dependency_name(dependency.name)
	_dependencies_dict[dependency_name] = dependency

## Deregisters a node dependency from the registrar.
func deregister_dependency(dependency_name: StringName) -> void:
	if dependency_name == "":
		push_warning("The 'dependency_name' being registered cannot be an empty string.")
		return
	
	dependency_name = DependencyInjectionHelper.get_resolved_dependency_name(dependency_name)
	_dependencies_dict.erase(dependency_name)
