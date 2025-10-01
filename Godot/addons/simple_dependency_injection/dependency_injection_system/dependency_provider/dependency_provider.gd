## Automatically provides the required node dependencies for valid injectables when they are added 
## to the [SceneTree]. [br][br]
## [u]Keep in mind[/u] that [i]_inject[/i] and [i]_post-inject[/i] calls happen after [i]_ready.[/i]
@tool
class_name DependencyProvider
extends Node


const INJECT_METHOD_NAME: StringName = "_inject"

@export_category("Dependencies")
@export var _dependency_registrar: DependencyRegistrar


func _enter_tree() -> void:
	get_tree().node_added.connect(_inject_dependencies_into)

func _exit_tree() -> void:
	get_tree().node_added.disconnect(_inject_dependencies_into)


## Sets the dependency registrar instance.
func set_dependency_registrar(dependency_registrar: DependencyRegistrar) -> void:
	_dependency_registrar = dependency_registrar


func _inject_dependencies_into(node: Node):
	if node.has_method(INJECT_METHOD_NAME):
		var method_info: Dictionary = DependencyInjectionHelper \
			.get_method_info(node, INJECT_METHOD_NAME)
		if method_info.args.is_empty():
			push_warning("The '[%s]' function on [%s] has no parameters." \
			% [INJECT_METHOD_NAME, node.name])
		
		var callable: Callable = Callable(node, INJECT_METHOD_NAME)
		var arguments: Array = []
		
		for parameter: Dictionary in method_info.args:
			var dependency_name: StringName = DependencyInjectionHelper \
				.get_resolved_dependency_name(parameter.name.to_pascal_case())
			arguments.append(_dependency_registrar.get_dependency(dependency_name))
			
		callable.callv(arguments)
