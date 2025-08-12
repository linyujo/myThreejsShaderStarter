import * as THREE from "three";

/**
 * Update Resize
 */
type TViewport = {
  width: number;
  height: number;
};
const updateResize = ({
  viewport,
  renderer,
  camera,
}: {
  viewport: TViewport;
  renderer: THREE.WebGLRenderer;
  camera: THREE.PerspectiveCamera;
}) => {
  window.addEventListener("resize", () => {
    console.log("window.innerWidth", window.innerWidth);
    // Update Canvas Size
    viewport.width = window.innerWidth;
    viewport.height = window.innerHeight;

    // Update renderer
    renderer.setSize(viewport.width, viewport.height);

    // Update camera
    camera.aspect = viewport.width / viewport.height;
    camera.updateProjectionMatrix();
  });
};

export default updateResize;
