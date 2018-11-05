shader_type canvas_item;

uniform float pos = 0;//-1.2;
uniform float texture_height = 81.0;
uniform float reference_height = 50.0;
uniform float texture_base_width = 641.0;
uniform float texture_top_width = 534.0;

void fragment()
{
	vec2 px = round( UV / TEXTURE_PIXEL_SIZE );
	float x_offset = ( ( texture_height - ( texture_height - reference_height ) ) - px.y ) * ( -pos ) / ( texture_base_width / 2.0 ) * texture_base_width / texture_top_width;
	vec4 c = texture( TEXTURE, ( px + vec2( x_offset, 0.0 ) ) * TEXTURE_PIXEL_SIZE );
	COLOR = c;
}
