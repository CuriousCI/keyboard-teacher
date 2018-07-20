class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    textSize = selfWidth / text.length();
    textAlign(CENTER, CENTER);
    setDynamicColors(#0021F0, #0021F0, #F021FF, #FFFFFF, #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000);
    edgeRoundness = (selfWidth - selfHeight / 2) / 10;
  }

  int changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked(true)) {
        return 1;
      } else {
        return 2;
      }
    } else {
      return 0;
    }
  }

  boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean selfClicked(boolean activated) {
    if (mouseInside() && mousePressed && activated) {
      return true;
    } else {
      return false;
    }
  }
}
