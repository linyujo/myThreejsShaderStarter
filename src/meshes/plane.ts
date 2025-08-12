import * as THREE from "three";
import { vertexShader, fragmentShader } from "../shaders/test";

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
  transparent: true,
});
const planeMesh = new THREE.Mesh(geometry, material);

export { planeMesh };
