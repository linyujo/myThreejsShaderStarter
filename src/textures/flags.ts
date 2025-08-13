import * as THREE from "three";

const textureLoader = new THREE.TextureLoader();

const taiwanFlagTexture = textureLoader.load(
  "/textures/flags/flag-taiwan.webp",
);

export { taiwanFlagTexture };
