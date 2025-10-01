## Provides the functionality for getting a resolved dependency name, 
## handles caching of class info for custom class checks, 
## as well as caching of method info.
class_name DependencyInjectionHelper
extends Node


static var _class_info_dict: Dictionary[StringName, Dictionary]
static var _method_info_cache: Dictionary[StringName, Dictionary]


static func _static_init() -> void:
	for class_dict: Dictionary in ProjectSettings.get_global_class_list():
		_class_info_dict[class_dict.class] = class_dict


static func get_resolved_dependency_name(
	dependency_name: StringName) -> StringName:
	if not _class_info_dict.has(dependency_name):
		return dependency_name
		
	# We get the base class name because all scripts with 
	# class_name defined have one in the global class list. 
	# We check if base class name is custom against the ClassDB because
	# only pre-defined engine classes exist there.
	var base_class_name: StringName = _class_info_dict.get(dependency_name).base
	if ClassDB.class_exists(base_class_name):
		return dependency_name
	
	var resolved_dependency_name: StringName = "%s/%s" % [base_class_name, dependency_name]
	return resolved_dependency_name


static func get_method_info(node: Node, method_name: StringName) -> Dictionary:
	var key: StringName = "%s.%s" % [node.name, method_name]
	
	if _method_info_cache.has(key):
		return _method_info_cache[key]
	
	# We iterate from the last method to skip the pre-existing methods that exist
	# from inheritance.
	var method_list: Array[Dictionary] = node.get_method_list()
	for i: int in range(method_list.size() - 1, -1, -1):
		var method: Dictionary = method_list[i]
		if method.name == method_name:
			_method_info_cache[key] = method
			return method
	return {}
