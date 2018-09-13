#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D fft;
uniform float time;

varying vec3 norm;

void main() {
  // Use the vertex normal to define the pixel color
  // vec4 c = vec4(norm, 1.0);
  // gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);

  float t = 10.0 * time;

  float bri = dot(norm, vec3(0.0, 1.0, 0.0));

  // float bri = sin(t + 50.0*dot(norm, vec3(0.0, 0.0, 1.0)));
  gl_FragColor = vec4(bri, bri, bri, 1.0);
}


