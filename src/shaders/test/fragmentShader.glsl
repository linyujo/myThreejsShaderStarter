precision mediump float;

varying vec2 vUv;

#define PI 3.1415926535897932384626433832795

float random(vec2 st) {
	return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, float rotation, vec2 mid) {
	return vec2(
		cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
		cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
	);
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
//
vec2 fade(vec2 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

vec4 permute(vec4 x) {
  return mod(((x*34.0)+1.0)*x, 289.0);
}

float cnoise(vec2 P){
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);
  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x,gy.x);
  vec2 g10 = vec2(gx.y,gy.y);
  vec2 g01 = vec2(gx.z,gy.z);
  vec2 g11 = vec2(gx.w,gy.w);
  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));
  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

void main() {

	// Pattern 1
	// gl_FragColor = vec4(vUv, 1.0, 1.0);

	// Pattern 2
	// gl_FragColor = vec4(vUv, 0.0, 1.0);

	// Pattern 3
	/*
		float strength = vUv.x;
		gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 4
	/*
	float strength = vUv.y;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 5
	/*
	float strength = 1.0 - vUv.y;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 6
	/*
	float strength = vUv.y * 10.0;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 7
	/*
	float strength = mod(vUv.y * 10.0, 1.0); // 當你計算 mod(任何數, 1.0) 時，你實際上是在問："這個數除以 1 後，剩下的小數部分是多少？"
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 8
	/*
	float strength = mod(vUv.y * 10.0, 1.0);
	strength = step(0.5, strength); // 不是0就是1，這就是為什麼 step 被稱為"階梯函數"。用來取代if else。
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 9
	/*
	float strength = mod(vUv.y * 10.0, 1.0);
	strength = step(0.8, strength); // 0.8 是門檻值，如果小於 0.8 則為0，否則為 1。
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 10
	/*
	float strength = mod(vUv.x * 10.0, 1.0);
	strength = step(0.8, strength);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 11
	float strengthX = mod(vUv.x * 10.0, 1.0);
	float strengthY = mod(vUv.y * 10.0, 1.0);
	float strength = step(0.8, strengthX) + step(0.8, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);

	// Pattern 12
	/*
	float strengthX = mod(vUv.x * 10.0, 1.0);
	float strengthY = mod(vUv.y * 10.0, 1.0);
	float stepFilter = 0.8;
	float strength = step(stepFilter, strengthX) * step(stepFilter, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 13
	/*
	float strengthX = mod(vUv.x * 10.0, 1.0);
	float strengthY = mod(vUv.y * 10.0, 1.0);
	float strength = step(0.4, strengthX) * step(0.8, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 14
	/*
	float strengthX = mod(vUv.x * 10.0, 1.0);
	float strengthY = mod(vUv.y * 10.0, 1.0);
	float barX = step(0.4, strengthX) * step(0.8, strengthY);
	float barY = step(0.8, strengthX) * step(0.4, strengthY);
	float strength = barX + barY;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 15
	/*
	float barX = step(0.4, mod(vUv.x * 10.0, 1.0)) * step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0));
	float barY = step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0)) * step(0.4, mod(vUv.y * 10.0, 1.0));
	float strength = barX + barY;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 16
	/*
	float strength = abs(vUv.x - 0.5);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 17
	/*
	float strengthX = abs(vUv.x - 0.5);
	float strengthY = abs(vUv.y - 0.5);
	float strength = min(strengthX, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 18
	/*
	float strengthX = abs(vUv.x - 0.5) * 1.5;
	float strengthY = abs(vUv.y - 0.5) * 1.5;
	float strength = max(strengthX, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 19
	/*
	float strengthX = abs(vUv.x - 0.5);
	float strengthY = abs(vUv.y - 0.5);
	float strength = step(0.2, strengthX) + step(0.2, strengthY);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/
	
	// Pattern 20
	/*
	float strengthX = abs(vUv.x - 0.5);
	float strengthY = abs(vUv.y - 0.5);
	float square1 = step(0.2, max(strengthX, strengthY));
	float square2 = 1.0 - step(0.25, max(strengthX, strengthY));
	float strength = square1 * square2;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 21
	/*
	float strength = floor(vUv.x * 10.0) * 0.1;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 22
	/*
	float increaseByX = floor(vUv.x * 10.0) * 0.1;
	float increaseByY = floor(vUv.y * 10.0) * 0.1;
	float strength = increaseByX * increaseByY;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 23
	/*
	float strength = random(vUv);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 24
	/*
	float increaseByX = floor(vUv.x * 10.0) * 0.1;
	float increaseByY = floor(vUv.y * 10.0) * 0.1;
	vec2 gridUv = vec2(increaseByX, increaseByY);
	float strength = random(gridUv);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 25
	/*
	float increaseByX = floor(vUv.x * 10.0) * 0.1;
	float increaseByY = floor((vUv.y + vUv.x * 0.5) * 10.0) * 0.1;
	vec2 gridUv = vec2(increaseByX, increaseByY);
	float strength = random(gridUv);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 26
	/*
	float strength = length(vUv);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 27
	/*
	// float strength = length(vUv - 0.5); // 方法1: vUv的中心往左移動半張紙
	float strength = distance(vUv - vec2(0.5, 0.5)); // 方法2: (0, 0)與(1, 1)的直線距離
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 28
	/*
	float strength = 1.0 - distance(vUv, vec2(0.5, 0.5));
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 29
	/*
	float strength = 0.015 / distance(vUv, vec2(0.5, 0.5));
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 30
	/*
	vec2 lightUv = vec2(
		vUv.x * 0.1 + 0.45,
		vUv.y * 0.5 + 0.25
	);
	float strength = 0.015 / distance(lightUv, vec2(0.5, 0.5));
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/
	
	// Pattern 31
	/*
	vec2 starUvX = vec2(
		vUv.x * 0.1 + 0.45,
		vUv.y * 0.5 + 0.25
	);
	float strengthX = 0.015 / (distance(starUvX, vec2(0.5, 0.5)));
	vec2 starUvY = vec2(
		vUv.x * 0.5 + 0.25,
		vUv.y * 0.1 + 0.45
	);
	float strengthY = 0.015 / (distance(starUvY, vec2(0.5, 0.5)));
	float strength = strengthX * strengthY;

	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 32
	/*
	vec2 uvRotated = rotate(vUv, PI * 0.25, vec2(0.5, 0.5)); // 先旋轉uv，再計算星星的uv
	vec2 starUvX = vec2(
		uvRotated.x * 0.1 + 0.45,
		uvRotated.y * 0.5 + 0.25
	);
	float strengthX = 0.015 / (distance(starUvX, vec2(0.5, 0.5)));

	vec2 starUvY = vec2(
		uvRotated.x * 0.5 + 0.25,
		uvRotated.y * 0.1 + 0.45
	);
	float strengthY = 0.015 / (distance(starUvY, vec2(0.5, 0.5)));

	float strength = strengthX * strengthY;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 33
	/*
	float strength = step(0.25, distance(vUv, vec2(0.5, 0.5)));
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 34
	/*
	float strength = abs(distance(vUv, vec2(0.5, 0.5)) - 0.25);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 35
	/*
	float showCircle = abs(distance(vUv, vec2(0.5, 0.5)) - 0.25) * 2.0;
	float strength = step(0.02, showCircle);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 36
	/*
	float showCircle = abs(distance(vUv, vec2(0.5, 0.5)) - 0.25) * 2.0;
	float strength = 1.0 - step(0.02, showCircle);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 37
	/*
	// 先建立一個波浪uv
	vec2 waveUv = vec2(
		vUv.x,
		vUv.y + sin(vUv.x * 30.0) * 0.1
	);
	float showWave = abs(distance(waveUv, vec2(0.5, 0.5)) - 0.25);
	float whiteBgWave = step(0.01, showWave);
	float strength = 1.0 - whiteBgWave;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 38
	/*
	vec2 waveUv = vec2(
		vUv.x + sin(vUv.y * 30.0) * 0.1,
		vUv.y + sin(vUv.x * 30.0) * 0.1
	);
	float showWave = abs(distance(waveUv, vec2(0.5, 0.5)) - 0.25);
	float whiteBgWave = step(0.01, showWave);
	float strength = 1.0 - whiteBgWave;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 39
	/*
	vec2 waveUv = vec2(
		vUv.x + sin(vUv.y * 100.0) * 0.1,
		vUv.y + sin(vUv.x * 100.0) * 0.1
	);
	float showWave = abs(distance(waveUv, vec2(0.5, 0.5)) - 0.25);
	float whiteBgWave = step(0.01, showWave);
	float strength = 1.0 - whiteBgWave;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 40
	/*
	float angle = atan(vUv.x, vUv.y);
	float strength = angle;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 41
	/*
	float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
	float strength = angle;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 42
	/*
	float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / PI;
	float strength = angle + 1.0;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 43
	/*
	float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / PI;
	float strength = angle + 1.0;
	float modolo = mod(strength * 10.0, 1.0);
	gl_FragColor = vec4(modolo, modolo, modolo, 1.0);
	*/

	// Pattern 44
	/*
	float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / PI;
	angle = angle + 1.0;
	float strength = sin(angle * 50.0);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 45
	/*
	float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / (2.0 * PI);
	angle = angle + 0.5;
	float sinusoid = sin(angle * 100.0) * 0.02;
	float radius = 0.25 + sinusoid;
	float showCircle = abs(distance(vUv, vec2(0.5, 0.5)) - radius);
	float strength = 1.0 - step(0.01, showCircle);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 46
	/*
	float strength = cnoise(vUv * 10.0);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 47
	/*
	float strength = cnoise(vUv * 10.0);
	strength = step(0.0, strength);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 48
	/*
	float strength = abs(cnoise(vUv * 10.0));
	strength = 1.0 - strength;
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 49
	/*
	float strength = cnoise(vUv * 10.0);
	strength = sin(strength * 20.0);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	// Pattern 50
	/*
	float strength = cnoise(vUv * 10.0);
	strength = sin(strength * 20.0);
	strength = step(0.9, strength);
	gl_FragColor = vec4(strength, strength, strength, 1.0);
	*/

	/*
	 * Mixed Color
	 */
	// clamp the strength to 0.0 ~ 1.0
	strength = clamp(strength, 0.0, 1.0);

	vec3 blackColor = vec3(0.0);
	vec3 uvColor = vec3(vUv, 1.0);
	vec3 mixedColor = mix(blackColor, uvColor, strength);
	gl_FragColor = vec4(mixedColor, 1.0);

	// float strength = mod(vUv.y * 10.0, 1.0);
	// gl_FragColor = vec4(strength, strength, strength, 1.0);
}