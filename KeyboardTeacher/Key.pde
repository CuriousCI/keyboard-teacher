class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  void dinamicColorChange(color a1, color a2, color a3, color b1, color b2, color b3, color c1, color c2, color c3, int tra) {
    transparency = tra;
    if (keyPressed) {
      if (key == text.charAt(0)) {
        boxColor(a1, a2, a3);
      }
    } else {
      boxColor(c1, c2, c3);
    }
  }
}
