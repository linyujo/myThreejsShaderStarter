import * as THREE from "three";
import gui from "../commons/gui";
import colorMap from "../commons/colorMap";
import { vertexShader, fragmentShader } from "../shaders/test";
import { taiwanFlagTexture } from "../textures/flags";

/**
 * Plane Mesh
 */
const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);
const count = geometry.attributes.position.count; // vertices的組數([x,y,z]為一組)
// const length = geometry.attributes.position.array.length; vertices的長度，為count的3倍

const randoms = new Float32Array(count);
Array.from({ length: count }).forEach((_, index) => {
  randoms[index] = Math.random();
});
geometry.setAttribute("aRandom", new THREE.BufferAttribute(randoms, 1));

const material = new THREE.RawShaderMaterial({
  vertexShader,
  fragmentShader,
  // transparent: true,
  uniforms: {
    uFrequency: { value: new THREE.Vector2(10, 5) },
    uTime: { value: 0 },
    uColor: { value: new THREE.Color(colorMap.LightSkyBlue) },
    uColorElevation: { value: new THREE.Vector2(5, 3) },
    uTexture: { value: taiwanFlagTexture },
  },
});
const planeMesh = new THREE.Mesh(geometry, material);
planeMesh.scale.y = 0.666666;

/**
 * gui controls
 */
const plane = gui.addFolder("Plane");
plane
  .add(material.uniforms.uFrequency.value, "x")
  .min(0)
  .max(20)
  .step(1)
  .name("uFrequency-x");
plane
  .add(material.uniforms.uFrequency.value, "y")
  .min(0)
  .max(20)
  .step(1)
  .name("uFrequency-y");
plane
  .add(material.uniforms.uColorElevation.value, "x")
  .min(0)
  .max(20)
  .step(1)
  .name("uColorElevation-x");
plane
  .add(material.uniforms.uColorElevation.value, "y")
  .min(0)
  .max(20)
  .step(1)
  .name("uColorElevation-y");
export { planeMesh };
