import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import updateResize from "./utils/updateResize";
import { viewport, canvasElement } from "./commons/base";
import { planeMesh } from "./meshes";

/**
 * Base
 */
// Scene
const scene = new THREE.Scene();

// Axes Helper
const axesHelper = new THREE.AxesHelper();
scene.add(axesHelper);

/**
 * Add Meshes
 */
scene.add(planeMesh);

/**
 * Camera
 */
// Base camera

const fov = 35;
const aspect = viewport.width / viewport.height;
const near = 0.1;
const far = 100;
const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
camera.position.set(0.5, 2.5, 2.5);
scene.add(camera);

// Controls
const controls = new OrbitControls(camera, canvasElement);
controls.enableDamping = true;

/**
 * Renderer
 */
const renderer = new THREE.WebGLRenderer({ canvas: canvasElement });
renderer.setSize(viewport.width, viewport.height);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

/**
 * Update Resize
 */
updateResize({ viewport, renderer, camera });

/**
 * Update uniform uTime
 */
const updateUniforms = (elapsedTime: number) => {
  planeMesh.material.uniforms.uTime.value = elapsedTime;
};

/**
 * Animate
 */
const clock = new THREE.Clock();
const tick = () => {
  const elapsedTime = clock.getElapsedTime();

  // Update uniforms
  updateUniforms(elapsedTime);

  // Update controls
  controls.update();

  // Render
  renderer.render(scene, camera);

  // Call tick again on the next frame
  window.requestAnimationFrame(tick);
};

tick();
