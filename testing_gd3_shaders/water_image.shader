shader_type canvas_item;
uniform sampler2D basetexture;
void fragment()
{
	//vec2 ps = 1.0/iResolution.xy;
	vec2 ps = TEXTURE_PIXEL_SIZE;
	vec2 uv = UV;//fragCoord.xy * ps;
	//float dx = texture(iChannel0,uv+vec2(ps.x,0.0)).x-texture(iChannel0,uv+vec2(-ps.x,0.)).x;
	//float dy = texture(iChannel0,uv+vec2(0.0,ps.y)).x-texture(iChannel0,uv+vec2(0.0,-ps.y)).x;
	float dx = texture( TEXTURE, UV + vec2( ps.x, 0.0 ) ).y - texture( TEXTURE, UV + vec2( -ps.x, 0.0 ) ).y;
	float dy = texture( TEXTURE, UV + vec2( 0.0, ps.y ) ).y - texture( TEXTURE, UV + vec2( 0.0, -ps.y ) ).y;
	float sc = 4.0;
	//COLOR = vec4( texture( TEXTURE, normalize( vec3( sin( sc * dx ), cos( sc * dx ) * cos( sc * dy ), sin( sc * dy ) ) ) ) );
	//COLOR = vec4( vec3( texture( TEXTURE, UV ).y ), 1.0 );
	COLOR = texture( basetexture, UV + vec2( dx, dy ) );
}











