shader_type canvas_item;

uniform float brightness = 0.3;

void fragment() {
	// Place fragment code here.
	COLOR = texture(TEXTURE, UV);
	COLOR.b = brightness;
	COLOR.r = brightness;
	COLOR.g = brightness;
}
