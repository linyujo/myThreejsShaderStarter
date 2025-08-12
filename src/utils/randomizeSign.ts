/**
 * 隨機回傳正數或負數
 * @param {number} value - 傳入的數字
 * @returns {number} 傳入數值的正值或負值，隨機決定
 */
function randomizeSign(value: number) {
  if (typeof value !== "number" || isNaN(value)) {
    throw new TypeError("請傳入有效的數字");
  }

  return value * (Math.random() < 0.5 ? 1 : -1);
}

export default randomizeSign;
