@tool
extends EditorPlugin


const DEPENDENCY_REGISTRAR_NAME: StringName = "DependencyRegistrar"
const DEPENDENCY_PROVIDER_NAME: StringName = "DependencyProvider"


func _enable_plugin() -> void:
	var scene_root = get_editor_interface().get_edited_scene_root()
	if scene_root:
		var dependency_registrar_scene: PackedScene = \
			ResourceLoader.load("uid://d2fvnr42s50t4") as PackedScene
		var dependency_provider_scene: PackedScene = \
			ResourceLoader.load("uid://dwye6xmnnckk5") as PackedScene
			
		var dependency_registrar: DependencyRegistrar = dependency_registrar_scene.instantiate()
		var dependency_provider: DependencyProvider = dependency_provider_scene.instantiate()
		
		dependency_provider.set_dependency_registrar(dependency_registrar)
		
		dependency_registrar.name = DEPENDENCY_REGISTRAR_NAME
		dependency_provider.name = DEPENDENCY_PROVIDER_NAME
		
		scene_root.add_child(dependency_registrar)
		scene_root.add_child(dependency_provider)
		
		dependency_registrar.owner = scene_root
		dependency_provider.owner = scene_root
		


func _disable_plugin() -> void:
	var scene_root = get_editor_interface().get_edited_scene_root()
	if scene_root:
		var registrar_node: Node = scene_root.find_child("DependencyRegistrar")
		if registrar_node and registrar_node is DependencyRegistrar:
			registrar_node.queue_free()

		var provider_node = scene_root.find_child("DependencyProvider")
		if provider_node and provider_node is DependencyProvider:
			provider_node.queue_free()
