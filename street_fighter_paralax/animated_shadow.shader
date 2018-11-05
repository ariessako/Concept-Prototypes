shader_type canvas_item;


uniform vec2 shadow_dir = vec2( -0.5, 0.25 );

varying float original_vertex;

void vertex()
{
	mat2 m = mat2( vec2( 1.0, 0.0 ), -shadow_dir );
	original_vertex = VERTEX.y;
	VERTEX = m * VERTEX;
	//VERTEX.x += 48.0 * 0.8 * 0.25;
}

void fragment()
{
	vec2 px = TEXTURE_PIXEL_SIZE;
	float a = texture( TEXTURE, UV ).a;
	a += texture( TEXTURE, UV + vec2( px.x, 0.0 ) ).a;
	a += texture( TEXTURE, UV + vec2( -px.x, 0.0 ) ).a;
	a += texture( TEXTURE, UV + vec2( 0.0, px.y ) ).a;
	a += texture( TEXTURE, UV + vec2( 0.0, -px.y ) ).a;
	a /= 5.0;
	
	COLOR.rgb *= 0.0;
	COLOR.a = a * 0.5;
		
		
//	vec4 c = texture( TEXTURE, UV );
//	c.rgb *= 0.0;
//	c.a *= 0.5;
//	c.b *= 1.2;
//	COLOR.rbg = a0;
//	COLOR.a = a;
	
}