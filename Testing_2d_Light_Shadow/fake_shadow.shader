shader_type canvas_item;

void vertex()
{
	VERTEX *= vec2( 1.0, -1.0 );
}

void fragment()
{
	COLOR = vec4( vec3( 0.0 ), texture( TEXTURE, UV ).a * 0.3 );
	
}
