void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    vec4 col = vec4(1., 1., 1., 1.);
    
    //rotation matrix
    float U = iTime*3.;
    mat3 mRotate;
    mRotate[0] = vec3(cos(U), sin(U), 0.);
    mRotate[1] = vec3(-sin(U), cos(U), 0.);
    mRotate[2] = vec3(0., 0., 1.);
    
    
    //* render circle
    vec2 shapepos = vec2(iResolution.x/2.+cos(iTime)*iResolution.x/2., iResolution.y/2.+sin(iTime)*iResolution.y/2.);
    vec2 p1 = fragCoord.xy - shapepos;
    if(sqrt(p1.x*p1.x + p1.y*p1.y) < 75.) {
        col = vec4(shapepos.x/iResolution.x, shapepos.y/iResolution.y, 1., 1.);
    }
    
    //* render rounded square
    vec2 shapepos2 = vec2(iResolution.x/2.+sin(iTime)*iResolution.x/2., iResolution.y/2.+cos(iTime)*iResolution.y/2.);
    float power = 16.;
    vec3 p2 = mRotate * vec3(fragCoord.xy - shapepos2, 1.);
    if(pow(p2.x, power) + pow(p2.y, power) < pow(75., power)) {
        col = vec4(shapepos.x/iResolution.x, shapepos.y/iResolution.y, 1., 1.);
    }

    //* render rotating square in the mouse
    vec2 shapepos3 = vec2(iMouse.x, iMouse.y);
    
    vec3 p3 = mRotate * vec3(fragCoord.xy - shapepos3, 1.);
    if(abs(p3.x) + abs(p3.y) < abs(cos(iTime)*200.)) {
        col = vec4(1., 0., 0., 1.);
        
    }
    fragColor = col;
}