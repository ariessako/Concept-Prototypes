shader_type canvas_item;

void fragment()
{
	vec3 c = texture( TEXTURE, UV ).rgb + texture( SCREEN_TEXTURE, UV+vec2(0.000,0.001) ).rgb * 0.93;
	COLOR = vec4( c, 1.0 );
}