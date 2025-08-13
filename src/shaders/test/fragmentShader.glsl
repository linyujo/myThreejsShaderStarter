precision mediump float;

uniform vec3 uColor;
uniform sampler2D uTexture;
uniform vec2 uFrequency;
uniform float uTime;
uniform vec2 uColorElevation;

varying float vRandom;
varying vec2 vUv;

void main() {
	// gl_FragColor = vec4(uColor, 1.0);
  float elevation = sin(uColorElevation.x * uFrequency.x - uTime) * 0.1 + 0.5;
	elevation += sin(uColorElevation.y * uFrequency.y - uTime) * 0.1 + 0.5;
	
	vec4 textureColor = texture2D(uTexture, vUv);
  textureColor.rgb *= elevation;

	gl_FragColor = textureColor;
}