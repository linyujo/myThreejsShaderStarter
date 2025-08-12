const viewport = {
  width: window.innerWidth,
  height: window.innerHeight,
};

const canvasElement = document.createElement("canvas") as HTMLCanvasElement;
canvasElement.id = "canvas";

const rootApp = document.querySelector("#app") as HTMLElement;
rootApp.insertBefore(canvasElement, rootApp.firstChild);

export { viewport, canvasElement };
