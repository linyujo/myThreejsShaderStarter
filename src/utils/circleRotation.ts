import * as THREE from "three";

const circleRotation = ({
  position,
  elapsedTime,
  radius,
}: {
  position: THREE.Vector3;
  elapsedTime: number;
  radius: number;
}) => {
  position.x = Math.cos(elapsedTime * 1) * radius;
  position.z = Math.sin(elapsedTime * 1) * radius;

  return position;
};

export default circleRotation;
