class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    textSize = selfWidth / text.length() / 2 + 10;
    textAlign(CENTER, CENTER);
    setDynamicColors(234324, #D0D0D0, 324324, 100, #D0D0D0, 90, 0, #D0D0D0, 50);
    edgeRoundness = 10;
  }

  int changeDynamicColors() {
    if (keyPressed) {
      if (text.length() == 1 && key == text.charAt(0)) {
        return 2;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }
}
