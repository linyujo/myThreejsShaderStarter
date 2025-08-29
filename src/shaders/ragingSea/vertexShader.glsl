#include "./classicPerlin3DNoise.glsl"

uniform float uBigWavesAmplitude;
uniform vec2 uBigWavesFrequency;
uniform float uBigWavesSpeed;
uniform float uTime;

uniform float uSmallWavesAmplitude;
uniform float uSmallWavesFrequency;
uniform float uSmallWavesSpeed;
uniform float uSmallWavesIterations;

varying float vElevation;

void main() {
	vec4 modelPosition = modelMatrix * vec4(position, 1.0);

	// 大波浪
	float elevation =
		sin(modelPosition.x * uBigWavesFrequency.x + uTime * uBigWavesSpeed) *
		sin(modelPosition.z * uBigWavesFrequency.y + uTime * uBigWavesSpeed) *
		uBigWavesAmplitude;

	// 小波浪
	for (float i = 1.0; i < uSmallWavesIterations; i++) { // uSmallWavesIterations: 讓小波浪看起來有隨機性
	  // -= 減去，讓小波浪的波峰與波谷都朝下，呈倒M字型
		// abs: 取絕對值，讓小波浪的波峰與波谷都朝上，呈M字型
		elevation -= abs(
			cnoise(vec3(
				modelPosition.xz * uSmallWavesFrequency * i, // uSmallWavesFrequency: 小波浪頻率（波峰與波谷的間隔）
				uTime * uSmallWavesSpeed // uSmallWavesSpeed: 小波浪速度
			))
			* uSmallWavesAmplitude / i // uSmallWavesAmplitude: 小波浪振幅（波峰與波谷的差值）
		);
	}
	
	modelPosition.y += elevation;

	vec4 viewPosition = viewMatrix * modelPosition;
	vec4 projectedPosition = projectionMatrix * viewPosition;

	gl_Position = projectedPosition;

	vElevation = elevation;
}