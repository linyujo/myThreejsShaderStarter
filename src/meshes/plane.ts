import * as THREE from "three";

/**
 * Plane Mesh
 */
const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);
const material = new THREE.MeshBasicMaterial();
const planeMesh = new THREE.Mesh(geometry, material);

export { planeMesh };
