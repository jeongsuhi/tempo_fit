
RegExp onlyNumber() {
  return RegExp(r'[0-9]');
}

RegExp notNumber() {
  return RegExp(r'[^0-9]');
}

RegExp under60() {
  return RegExp(r'^[0-5]?\d$');
}