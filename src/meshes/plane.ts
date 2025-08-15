import * as THREE from "three";
import { vertexShader, fragmentShader } from "../shaders/ragingSea";

/**
 * Plane Mesh
 */
const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);
const material = new THREE.ShaderMaterial({
  vertexShader,
  fragmentShader,
});
const planeMesh = new THREE.Mesh(geometry, material);
planeMesh.rotation.x = -Math.PI * 0.5;

export { planeMesh };
