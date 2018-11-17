shader_type canvas_item;
//( SCREEN_UV.y - sprite_uv_h * ( 1.0 - 2.0 * UV.y) + sprite_uv_h )* 1.2
void light()
{
	vec2 px = TEXTURE_PIXEL_SIZE;
	float sprite_h = 0.0*16.0 * 1.0 * px.y;
	float refy = 0.0;
	
	float y = ( LIGHT_VEC.y - 17.0 + LIGHT_HEIGHT ) * px.y + ( 1.0 - UV.y );
	
	if( y < 0.0 )
	{
		LIGHT = LIGHT;
	}
	else
	{
		LIGHT = vec4( 0.0, 0.0, 0.0, 0.0 );
	}
}
