import * as THREE from "three";
import gui from "../commons/gui";
import { vertexShader, fragmentShader } from "../shaders/ragingSea";

const colorTweaks = {
  depthColor: "#46b6fb",
  surfaceColor: "#94d6ff",
};

/**
 * Plane Mesh
 */
const geometry = new THREE.PlaneGeometry(2, 2, 512, 512);
const material = new THREE.ShaderMaterial({
  vertexShader,
  fragmentShader,
  uniforms: {
    uBigWavesAmplitude: { value: 0.2 }, // 振幅（波峰與波谷的差值）
    uBigWavesFrequency: { value: new THREE.Vector2(2, 4) }, // 頻率（波峰與波谷的間隔）
    uBigWavesSpeed: { value: 0.5 }, // 速度（波峰與波谷的移動速度）

    uSmallWavesAmplitude: { value: 0.15 }, // 小波浪振幅
    uSmallWavesFrequency: { value: 3.0 }, // 小波浪頻率
    uSmallWavesSpeed: { value: 0.2 }, // 小波浪速度
    uSmallWavesIterations: { value: 4.0 }, // 小波浪迭代次數

    uDepthColor: { value: new THREE.Color(colorTweaks.depthColor) },
    uSurfaceColor: { value: new THREE.Color(colorTweaks.surfaceColor) },
    uColorOffset: { value: 0.2 }, // 顏色偏移
    uColorMultiplier: { value: 5 }, // 顏色強度

    uTime: { value: 0 },
  },
});
const planeMesh = new THREE.Mesh(geometry, material);
planeMesh.rotation.x = -Math.PI * 0.5;

/**
 * gui
 */
gui
  .add(material.uniforms.uBigWavesAmplitude, "value")
  .min(0)
  .max(1)
  .step(0.001)
  .name("uBigWavesAmplitude");

gui
  .add(material.uniforms.uBigWavesFrequency.value, "x")
  .min(0)
  .max(8)
  .step(0.01)
  .name("uBigWavesFrequency-x");

gui
  .add(material.uniforms.uBigWavesFrequency.value, "y")
  .min(0)
  .max(8)
  .step(0.01)
  .name("uBigWavesFrequency-y");

gui
  .add(material.uniforms.uBigWavesSpeed, "value")
  .min(-2)
  .max(2)
  .step(0.1)
  .name("uBigWavesSpeed");

gui
  .addColor(colorTweaks, "depthColor")
  .name("uDepthColor")
  .onChange((value: THREE.Color) => {
    material.uniforms.uDepthColor.value.set(value);
  });
gui
  .addColor(colorTweaks, "surfaceColor")
  .name("uSurfaceColor")
  .onChange((value: THREE.Color) => {
    material.uniforms.uSurfaceColor.value.set(value);
  });

gui
  .add(material.uniforms.uColorOffset, "value")
  .min(0)
  .max(1)
  .step(0.1)
  .name("uColorOffset");

gui
  .add(material.uniforms.uColorMultiplier, "value")
  .min(1)
  .max(10)
  .step(0.1)
  .name("uColorMultiplier");

gui
  .add(material.uniforms.uSmallWavesAmplitude, "value")
  .min(0)
  .max(1)
  .step(0.01)
  .name("uSmallWavesAmplitude");

gui
  .add(material.uniforms.uSmallWavesFrequency, "value")
  .min(0)
  .max(10)
  .step(0.1)
  .name("uSmallWavesFrequency");

gui
  .add(material.uniforms.uSmallWavesSpeed, "value")
  .min(0)
  .max(4)
  .step(0.01)
  .name("uSmallWavesSpeed");

gui
  .add(material.uniforms.uSmallWavesIterations, "value")
  .min(1)
  .max(5)
  .step(1)
  .name("uSmallWavesIterations");

export { planeMesh };
