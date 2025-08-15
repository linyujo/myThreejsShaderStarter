import * as THREE from "three";
import { vertexShader, fragmentShader } from "../shaders/test";

/**
 * Plane Mesh
 */
const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);
console.log("geometry.attributes", geometry.attributes);
const material = new THREE.ShaderMaterial({
  vertexShader,
  fragmentShader,
});
const planeMesh = new THREE.Mesh(geometry, material);

export { planeMesh };
