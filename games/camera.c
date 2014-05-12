/// rotate the camera around (0, 0, 0)
vec3 forward = {0, 0, 1}, direction;
float r = rotY * DEG_TO_RAD;
float c = cosf(r);
float s = sinf(r);
direction.x = c * forward.x - s * forward.z;
direction.z = s * forward.x + c * forward.z;

eye.x += direction.x * -delta.x;
eye.z += direction.z * -delta.z;