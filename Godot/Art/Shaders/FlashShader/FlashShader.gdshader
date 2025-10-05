shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform sampler2D albedo_texture : source_color;
uniform vec4 albedo_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float metallic : hint_range(0.0, 1.0) = 0.0;
uniform float roughness : hint_range(0.0, 1.0) = 1.0;
uniform float specular : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	// Get base color from texture or use solid color
	vec4 tex_color = texture(albedo_texture, UV);
	vec3 base_color = tex_color.rgb * albedo_color.rgb;

	// Mix base color with flash color based on flash_strength
	ALBEDO = mix(base_color, flash_color.rgb, flash_strength);
	ALPHA = tex_color.a * albedo_color.a;

	// Set material properties for lighting
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}