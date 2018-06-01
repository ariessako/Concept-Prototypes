shader_type canvas_item;

uniform vec4 c2 : hint_color;
uniform vec4 c1 : hint_color;

void fragment()
{
	vec2 px = TEXTURE_PIXEL_SIZE * 3.0;
	float a = texture( TEXTURE, UV ).r;
	a += texture( TEXTURE, UV + vec2( -px.x, -px.y ) ).r;
	a += texture( TEXTURE, UV + vec2( 0.0, -px.y ) ).r;
	a += texture( TEXTURE, UV + vec2( px.x, -px.y ) ).r;
	a += texture( TEXTURE, UV + vec2( -px.x, 0.0 ) ).r;
	a += texture( TEXTURE, UV + vec2( px.x, 0.0 ) ).r;
	a += texture( TEXTURE, UV + vec2( -px.x, px.y ) ).r;
	a += texture( TEXTURE, UV + vec2( 0.0, px.y ) ).r;
	a += texture( TEXTURE, UV + vec2( px.x, px.y ) ).r;
	a /= 9.0;
	
	
	vec4 c = vec4( 0.0 );
	if( a > 0.8 )
	{
		c = c1;
	}
	else if( a > 0.5 )
	{
		c = c2;
	}
	
	
	COLOR = c;
}
