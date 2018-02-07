shader_type canvas_item;

void fragment()
{
	vec2 ps = TEXTURE_PIXEL_SIZE;//1.0/iResolution.xy;
	vec2 iResolution = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 uv = UV;//fragCoord.xy * ps;
	vec2 fragCoord = UV / TEXTURE_PIXEL_SIZE;
	
	float h = texture( SCREEN_TEXTURE, uv).x - 0.5;
	float v = texture( SCREEN_TEXTURE, uv).y - 0.5;
	
	float hu = ( texture( SCREEN_TEXTURE, uv + vec2( 0.0, -ps.y ) ).x - 0.5 ) - h;
	float hd = ( texture( SCREEN_TEXTURE, uv + vec2( 0.0, ps.y ) ).x - 0.5 ) - h;
	float hl = ( texture( SCREEN_TEXTURE, uv + vec2( -ps.x, 0.0 ) ).x - 0.5 ) - h;
	float hr = ( texture( SCREEN_TEXTURE, uv + vec2( ps.x, 0.0 ) ).x - 0.5 ) - h;
	
	v -= 0.1*h;
	v += (hu+hd+hl+hr)*0.25;//0.4;
	v *= 0.98;
	h += v;
	if( mod( TIME, 1.0 ) < .1 )
	{
		float amp = 0.5 + 0.5 * sin( TIME * 0.01 );
		float dropsize = 12.0/12.0 + 10.0 * sin( TIME * 153.6 );
		//vec2 off = iResolution.xy * vec2(0.5+0.5*sin(floor(iTime*5.)*17.541),0.5+0.5*sin(floor(iTime*5.)*9.327));
		vec2 off = iResolution.xy * vec2( 0.5 + 0.5 * sin( floor( TIME * 5.0 ) * 17.541 ), 0.5 + 0.5 * sin( floor( TIME * 5.0 ) * 9.327 ) );
		if( length( fragCoord - off ) < dropsize )
		{
			h = -0.5 * amp * ( 1.0 - length( fragCoord - off ) / dropsize );
		}
	}
	/*
	if (iMouse.x!=.0) {
	    float amp = 1.0;
	    float dropsize = 10.0;
	    vec2 off = iMouse.xy;
	    if (length(fragCoord-off)<dropsize) h=-0.5*amp*(1.0-length(fragCoord-off)/dropsize);        
	    
	}
	*/
	/*
	if (iFrame==0) {
	    h = 0.0;
	    v = 0.0;
	}
	*/
	//h = clamp(h,-0.1,0.1);
	v = clamp( v, -0.5, 0.5 );
	COLOR = vec4( h + 0.5, v + 0.5, 0.0, 1.0 );
}