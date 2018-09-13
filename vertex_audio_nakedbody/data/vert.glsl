uniform mat4 transform;
uniform mat4 modelview;
uniform mat3 normalMatrix;
uniform mat4 projectionMatrix;

attribute vec4 vertex;
attribute vec3 normal;
attribute vec3 position;

uniform sampler2D fft;
uniform float time;

varying vec3 norm;
varying vec3 fPosition;

void main() {
  norm = normalize(normalMatrix * normal); // Vertex in eye coordinates
  
  // Here we use the normal to decide which point in the fft texture
  // to sample from. You don't need to use norm, you could use something
  // else like the vertex position.
  vec2 posInImage = vec2(0.5 + 0.5 * norm.x, 0.0);
  // Look at one pixel in the fft texture
  vec4 c = texture2D(fft, posInImage);

  vec4 pos = modelview * vec4(position, 1.0);
  fPosition = pos.xyz;

  // float amount = min(0.0, pos.x);
  // float amount = clamp(0.2, 1.0, sin(time*5.));
  float amount = clamp(sin(time*10.0), 0.0, 0.5);

  // gl_Position = projectionMatrix * pos + amount*sin(time*10. + pos.x*20.);
  
  gl_Position = transform * vertex;
  // Use the value obtained to deform the mesh
  gl_Position.y += c.r * 100.0 * amount;
}
