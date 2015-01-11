precision mediump float;

varying vec2 surfacePosition;
float radius = .5;

void main(void) {
	vec2 pos = surfacePosition;
	float z = sqrt(radius * radius - pos.x * pos.x - pos.y * pos.y);
	vec3 normal = normalize(vec3(pos.x, pos.y, z));
	
	vec3 light = normalize(vec3(.5, 1, 1));
	float diffuse = dot(light, normal);
	
	if (length(pos) < radius)
		gl_FragColor = vec4(vec3(abs(diffuse)), 0);
	else
		discard;
}