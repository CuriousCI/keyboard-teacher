class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    if (textSize != 1) {
      textSize = selfWidth / text.length() / 2 + 10;
    }
    textAlign(CENTER, CENTER);
  }

  void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  void changeDynamicColors() {
    if (keyPressed) {
      if (text.length() == 1 && key == text.charAt(0)) {
        setColors(0, #D0D0D0, 50);
      } else {
        setColors(100, #D0D0D0, 90);
      }
    } else {
      setColors(100, #D0D0D0, 90);
    }
  }
}
