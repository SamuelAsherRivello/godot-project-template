extends MeshInstance3D
class_name HitFlashMeshInstance3D

@export var flash_duration: float = 0.2
@export var flash_color: Color = Color.WHITE

var _flash_material: ShaderMaterial = null
var _flash_timer: float = 0.0
var _flashing: bool = false

func _ready() -> void:
	# Get the material from this mesh instance
	_flash_material = get_active_material(0) as ShaderMaterial

	if _flash_material == null:
		push_error("Missing material on %s! Make sure FlashShaderMaterial is assigned." % name)
		return

	# Make material unique for this instance
	_flash_material = _flash_material.duplicate()
	set_surface_override_material(0, _flash_material)

	_flash_material.set_shader_parameter("flash_color", flash_color)
	_flash_material.set_shader_parameter("flash_strength", 0.0)

func _process(delta: float) -> void:
	if _flashing:
		_flash_timer -= delta
		var t: float = clamp(_flash_timer / flash_duration, 0.0, 1.0)
		_flash_material.set_shader_parameter("flash_strength", t)
		if _flash_timer <= 0.0:
			_flashing = false
			_flash_material.set_shader_parameter("flash_strength", 0.0)

func flash() -> void:
	if _flash_material == null:
		push_warning("Cannot flash - material not initialized")
		return
	_flash_timer = flash_duration
	_flashing = true