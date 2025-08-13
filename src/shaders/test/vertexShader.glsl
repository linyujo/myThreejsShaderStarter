precision mediump float;


uniform mat4 projectionMatrix; // projection
uniform mat4 viewMatrix; // camera
uniform mat4 modelMatrix; // mesh

uniform vec2 uFrequency;
uniform float uTime;
uniform vec2 uColorElevation;

// attribute是geometry.attributes
attribute vec3 position;
attribute float aRandom;
attribute vec2 uv;


// 傳送geometry.attributes的資料到fragment shader，因為fragment shader無法直接使用geometry.attributes
varying float vRandom;
varying vec2 vUv;

void main() {
	vec4 modelPosition = modelMatrix * vec4(position, 1.0);
  modelPosition.z += sin(modelPosition.x * uFrequency.x - uTime) * 0.1;
	modelPosition.z += sin(modelPosition.y * uFrequency.y - uTime) * 0.1;
	
	vec4 viewPosition = viewMatrix * modelPosition;
	vec4 projectedPosition = projectionMatrix * viewPosition;
	gl_Position = projectedPosition;

	vUv = uv;
}