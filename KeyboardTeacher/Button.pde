class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  void dinamicColorChange(color a1, color a2, color a3, color b1, color b2, color b3, color c1, color c2, color c3, int tra) {
    transparency = tra;
    if (mouseInside()) {
      if (buttonClicked()) {
        boxColor(a1, a2, a3);
        if (tra == 200) {
          transparency = 100;
        }
      } else {
        boxColor(b1, b2, b3);
      }
    } else {
      boxColor(c1, c2, c3);
    }
  }

  boolean mouseInside() {
    if ((mouseX < x + boxWidth && mouseX > x) && (mouseY < y + boxHeight && mouseY > y)) {
      return true;
    } else {
      return false;
    }
  }

  boolean buttonClicked() {
    if (mouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
