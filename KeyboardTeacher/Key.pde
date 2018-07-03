class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  int changeDynamicColors() {
    if (keyPressed) {
      if (key == text.charAt(0)) {
        return 0;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }
}
