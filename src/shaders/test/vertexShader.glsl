uniform mat4 projectionMatrix; // projection
uniform mat4 viewMatrix; // camera
uniform mat4 modelMatrix; // mesh

attribute vec3 position;
attribute float aRandom;

// 傳送資料到vertex shader
varying float vRandom;

void main() {
	vec4 modelPosition = modelMatrix * vec4(position, 1.0);
  // modelPosition.z = modelPosition.z + sin(modelPosition.x * 10.0) * 0.1;
  modelPosition.z += aRandom * 0.1;
	vRandom = aRandom;
	
	vec4 viewPosition = viewMatrix * modelPosition;
	vec4 projectedPosition = projectionMatrix * viewPosition;
	gl_Position = projectedPosition;
}