class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  int changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked()) {
        return 0;
      } else {
        return 1;
      }
    } else {
      return 2;
    }
  }



  boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean selfClicked() {
    if (mouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
